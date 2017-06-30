#writes a few lines to ta specified file

file = File.open('smalldata.txt', 'w')

File.open("../../simple_somatic_mutation.open.BRCA-EU.vcf"){|f|
  633000.times do
    file.syswrite(f.gets)
  end
}
