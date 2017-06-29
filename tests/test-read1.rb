puts "running"
time1= Time.new
begin
file = IO.readlines("simple_somatic_mutation.open.BRCA-EU.vcf")
rescue
  puts "too large"
end
time2 = Time.new

puts time2-time1
a = 0
4.times do
  puts file[a]
  a +=1
end
