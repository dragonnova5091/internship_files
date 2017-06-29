#this is a test for BioRuby
require 'bio'
#require 'bio-samtools'

puts 'hello'

testseq = Bio::Sequence::NA.new("atgcatgcaaaa")
puts testseq
puts testseq.complement

seq = testseq.subseq(2,10)
puts seq


puts "---" * 50

bamobj = Bio::DB::Sam.new(:bam => 'testbam1.bam', :fasta => 'ref.fasta')
bamobj.index()

puts bamobj.fetchreference("Chr1", 1, 100)
