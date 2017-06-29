#this is a test for BioRuby
require 'bio'

puts 'hello'

testseq = Bio::Sequence::NA.new("atgcatgcaaaa")
puts testseq
puts testseq.complement

seq = testseq.subseq(2,10)
puts seq
