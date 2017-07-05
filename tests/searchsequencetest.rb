#testing usages for BioRuby and Samtools
#probably not gonna work

require 'bio'
#require 'bio-samtools'
puts "starting"
arr = "acgt".split("")


if File.exist?('sequence.txt')
  puts "file exists"
else
  file = File.open("sequence.txt", "w")

  rand(500..1500).times do
    seq_full = ""
    10000.times do
      num = rand(0..3)
      seq_full += arr[num]
    end
    file.syswrite(seq_full)
    file.syswrite("\n")
  end
  file.close
end

puts "made the file"


notfound = true
puts "starting the loop"
while notfound

  key = ""
  arr = "acgt".split("")

  rand(10..30).times do
    num = rand(0..3)
    key += arr[num]
  end
  puts "new key"
  #key = "tcag"
  #sleep 0.2


  counts = [3000,5000,7000,13000]
  counts.each do |count|

    #seq = "aattccgg"
    File.open('sequence.txt').each_slice(count){|seq|
      puts "checking for the key"
      #print seq
      #sleep 1
      seq.each do |line|
        if line.include?(key)
          notfound = false
        end
      end
      #notfound = false
    }
  end
end
