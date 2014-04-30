require 'erb'


Encoding.default_external = 'UTF-8'
def quote(str)
	'"'+str+'"'
end

def line2entry(tokens)
	day = tokens[0].split("/")[2]
	work = tokens[3].gsub("\n", "")
	"[#{quote(day)},#{quote(work)}]"
end

lines = open('works.tsv') {|fp| fp.readlines}
array_code = lines.map do|line|
	line2entry(line.split("\t"))
end.join(",")

puts ERB.new(DATA.read).result(binding)

__END__

Func addJob($day, $value)
	#�q���g: MouseClick(<�{�^��>, x���W, y���W, �N���b�N��)
	#���t�����
	MouseClick("left",1600,685,1)
	Send($day)
	#���Ԃ����
	MouseClick("left",1730,685,2)
	Send($value)
	#�o�^
	MouseClick("left",1780,685,1)
EndFunc

Dim $works = [<%= array_code%>]

$count = UBound($works)

For $i = 0 To $count-1 Step 1
	addJob($works[$i][0], $works[$i][1])
Next