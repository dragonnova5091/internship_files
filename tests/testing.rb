#some tests
Dir.chdir("../patientfiles")
num = Dir.glob("*")

puts num.length








file = IO.readlines("../patientfiles/donorDONOR=DO217786.txt")
#print file[0].split("\t")
puts file.length

a = 0
closetogether = []

file.each do
  if a < (file.length-2)
    line1 = file[a].split("\t")
    line2 = file[a+1].split("\t")

    if (line1[1].to_i - line2[1].to_i).abs < 100

      temp = [a, a+1]
      closetogether << temp
    end
    a+=1
  end
end
print closetogether
print "\n"

a = 0
closetogether = []

file.each do
  if a < (file.length-2)
    line1 = file[a].split("\t")
    line2 = file[a+1].split("\t")

    if (line1[1].to_i - line2[1].to_i).abs < 50

      temp = [a, a+1]
      closetogether << temp
    end
    a+=1
  end
end
print closetogether
print "\n"

a = 0
closetogether = []

file.each do
  if a < (file.length-2)
    line1 = file[a].split("\t")
    line2 = file[a+1].split("\t")

    if (line1[1].to_i - line2[1].to_i).abs < 25

      temp = [a, a+1]
      closetogether << temp
    end
    a+=1
  end
end
print closetogether
print "\n"


closetogether.each do |pair|
#  puts file[pair[0]]
#  puts file[pair[1]]
end
