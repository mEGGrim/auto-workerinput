#-*- encoding: utf-8 -*-
require 'csv'
require 'date'

# �ΑӃf�[�^
class WorkData
  attr_reader :callendar, :work_time
  def initialize(row)
    begin
    #���t
    @callendar = Date.parse(row[4]).day
    #�������Ԃ𐔒l�ɕύX����B15���P�ʂɐ؂�̂ď����Ȃ�
    @work_time = row[15].split(':')[0].to_i + (row[15].split(':')[1].to_f / 60 * 4).floor * 0.25
    # �p�[�X�G���[�Ȃǂ�����Ԃ�
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

#��������csv�t�@�C���̓ǂݍ���
if !ARGV[0]
  puts "�Α�CSV�������Ɏw�肵�ĉ�����"
  exit(1) 
end
calendar = WorkCalendar.new(CSV.read(ARGV[0]))

File.open('./run.au3', 'w') do |f|
  f.puts <<EOS
# �N���b�N���W�����p
# #include <MsgBoxConstants.au3>
# Local $aPos = MouseGetPos()
# MsgBox($MB_SYSTEMMODAL, "Mouse x, y:", $aPos[0] & ", " & $aPos[1])

Func addJob($day, $value)
	# MouseClick(<�{�^��>, x���W, y���W, �N���b�N��)
	# ���t�����
	MouseClick("left",1600,685,1)
	Send($day)
	# ���Ԃ����
	MouseClick("left",1730,685,2)
	Send($value)
	# �o�^
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
