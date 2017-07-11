#sort tests


def fixer(filename)
	file = IO.readlines(filename)

	limits = [] 
	mutations = [] 

	file.each do |line|
		line = line.split("\t")
		limits << line[0]
		mutations << line[1]
	end

	limits = limits.uniq
	mutations = mutations.uniq

	temparray = [] 
	limits.each do |line|
		line = line.split(",")
		temparray << line
	end

	limits = temparray


	temparray = [] 
	mutations.each do |line|
		line = line.split(",")
		temparray << line 
	end

	mutations = temparray

	#print mutations
	#gets 


	ind = 0 
	newfile = []

	limits.each do 
		#puts "try 1"
		indx = 0
		wrote = false
		mutations.each do 
			#puts "made it here"
			#print mutations
			#print "\n"
			#print limits[ind]
			#print "\n"
			#gets
			if limits[ind][0] == mutations[indx][0] && limits[ind][1].to_i < mutations[indx][1].to_i && limits[ind][2].to_i > mutations[indx][1].to_i
				if wrote == false
					#puts "farther down"
					newfile[ind] = "#{limits[ind].join(",")}\t#{mutations[indx].join(",")}"
					wrote = true
				else
					newfile[ind] = "#{newfile[ind]}\t#{mutations[indx].join(",")}"
				end

				mutations.delete_at(indx)
				indx -=1
			end
			indx = indx + 1
		end
		ind += 1 
	end

	puts newfile
	writer = File.open(filename, "w")

	newfile.each do |line|
		writer.syswrite("#{line}\n")
	end

end


fixer('test_genechunklimitsdata.txt')