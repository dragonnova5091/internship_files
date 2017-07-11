#gene replacement tests\
a = 1
while true
big_genome_good = []
big_genome_bad = []

20000.times do 

	seq = ""
	arr = "acgt".split("")

	21.times do 
		num = rand(0..3)
		seq += arr[num]
	end

	big_genome_good << seq

	type = rand(1..10)

	case 
		when type >= 1 && type <8 #single switch
			#puts 1
			#puts seq
			num = rand(0..3)
			seq = seq.split("")
			while seq[10] == arr[num]
				num = rand(0..3)
			end
			seq[10] = arr[num]
			seq = seq.join

		when type == 8 #multiple switch
			#puts 2
			#puts seq
			nu = rand(2..4)

			ar = seq[10..(10+nu)]

			while ar == seq[10..(10+nu)]
				ar = []
				nu.times do 
					num = rand(0..3)
					ar << arr[num]
				end
			end
			
			i = 0
			seq = seq.split("")
			nu.times do 
				seq[10+i] = ar[i]
				i+=1
			end

			seq = seq.join

		when type == 9 #Add
			#puts 3
			#puts seq
			nu = rand(1..5)
			seq = seq.split("")

			ar = []
			nu.times do 
				num = rand(0..3)
				ar << arr[num]
			end

			seq = seq.insert(10, ar)
			seq = seq.join

		when type == 10
			#puts 4
			#puts seq
			nu = rand(1..5)

			seq = seq.split("")

			nu.times do 
				seq.delete_at(10)
			end

			seq = seq.join
	end

	big_genome_bad << seq 

	#puts seq

	#puts "~"

  #gets
end 


big_genome_bad = big_genome_bad.join
big_genome_good = big_genome_good.join


targseq = "aattccggatcgatcggctagcta"

if big_genome_bad.include?(targseq)
	puts "contains: #{targseq}"
	puts "at index #{num}"
	puts "times looped #{a}"
	exit
end
a += 1
end