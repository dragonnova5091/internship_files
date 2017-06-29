system('cls')

puts "started running"

lines100 = Array.new

File.open("simple_somatic_mutation.open.BRCA-EU.vcf"){|f|
  100.times do
    #puts f.gets
    lines100 << f.gets
  end
}

donor = []
for line in lines100
  !line.split("\t")
  print line
  lin = line[7].split(",")
  donor << lin[3]
end

donor.each do |num|
  print "#{num}  "
end

puts "\nit ran\n\n"
