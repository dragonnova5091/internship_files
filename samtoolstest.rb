#ruby calling samtools trial

system('samtools faidx hg19.fa chr1:123456-123467')
#print "--#{var}"

gets
place = 'chr1:123456-123467'
var = `samtools faidx hg19.fa #{place}`
print var