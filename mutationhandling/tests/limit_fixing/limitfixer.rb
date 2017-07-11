#fix the incorrect limits

def limit_fixer(filename)
	file = IO.readlines(filename)

	toosmall = []
	ind = 0 
	file.each do |line|
		if line.split(",")[4].split("").length > 3
			puts "too big"
			puts line 
			puts ind
			temparray = [ind, line]
			toosmall << temparray
		end
		ind += 1 
	end

	ind = 0
	toosmall.each do |lin|

		if lin[1].split("\t").length > 2
			line = lin[1].split("\t")

			line[0] = line[0].split(",")
			line[line.length-1] = line[line.length-1].split(",")

			line[0][1] = line[0][0].to_i + 20 + line[line.length-1][2].split("").length + 20

			line[0] = line[0].join(",")
			line[line.length-1] = line[line.length-1].join(",")

			full = ""
			line.each do |chunk|
				full += "\t#{chunk}"
			end
		else
			line = lin[1].split("\t")

			line[0] = line[0].split(",")
			line[1] = line[1].split(",")

			line[0][1] = line[0][0].to_i + 20 + line[1][2].split("").length + 20

			line[0] = line[0].join(",")
			line[1] = line[1].join(",")

			full = [line[0], line[1]].join("\t")
		end

		lin[1] = full 
		toosmall[ind] = lin
		ind +=1

	end

	newfile = file 

	toosmall.each do |pair|
		newfile[pair[0]] = pair[1]
	end

	file = File.open(filename, "w")
	newfile.each do |line|
		file.syswrite(line)
	end
end

limit_fixer("testdata.txt")