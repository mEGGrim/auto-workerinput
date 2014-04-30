#-*- encoding: utf-8 -*-
require 'csv'
require 'date'

# 勤怠データ
class WorkData
  attr_reader :callendar, :work_time
  def initialize(row)
    begin
    #日付
    @callendar = Date.parse(row[4]).day
    #実働時間を数値に変更する。15分単位に切り捨て処理など
    @work_time = row[15].split(':')[0].to_i + (row[15].split(':')[1].to_f / 60 * 4).floor * 0.25
    # パースエラーなどを握りつぶす
    rescue => ex
      @callendar = nil
    end
  end

  def to_s
    "\"#{@callendar}\", \"#{@work_time}\""
  end
end

class WorkCalendar < Array
  def initialize(csv)
    csv.each do |row|
        d = WorkData.new(row)
        self.push d if d.callendar
    end
  end
  def to_s
    str = ''
    str << "[#{self[0]}]"
    self[1..-1].each do |row|
      str << ",[#{row}]"
    end
    str
  end
end

#第一引数のcsvファイルの読み込み
if !ARGV[0]
  puts "勤怠CSVを引数に指定して下さい"
  exit(1) 
end
calendar = WorkCalendar.new(CSV.read(ARGV[0]))

File.open('./run.au3', 'w') do |f|
  f.puts <<EOS
# クリック座標調査用
# #include <MsgBoxConstants.au3>
# Local $aPos = MouseGetPos()
# MsgBox($MB_SYSTEMMODAL, "Mouse x, y:", $aPos[0] & ", " & $aPos[1])

Func addJob($day, $value)
	# MouseClick(<ボタン>, x座標, y座標, クリック回数)
	# 日付を入力
	MouseClick("left",1600,685,1)
	Send($day)
	# 時間を入力
	MouseClick("left",1730,685,2)
	Send($value)
	# 登録
	MouseClick("left",1780,685,1)
EndFunc

Dim $works = [#{calendar}]

$count = UBound($works)

For $i = 0 To $count-1 Step 1
	addJob($works[$i][0], $works[$i][1])
Next
EOS
end

system('start .\\run.au3')
