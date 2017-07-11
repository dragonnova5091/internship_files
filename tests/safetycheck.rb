#safe checks

oversizelines = [] 

Dir.glob("../patientfiles/genechunksdata/*.txt").each do |filename|

	file = IO.readlines(filename)

	file.each do |line|
		if line.split("\t").length >2
			line.split("\t").each do |section|
				if section.split(",").length > 3
					if section.split(",")[2].split("").length > 5
						oversizelines << section.split(",")[2].split("").length
					end
				end
			end
		end
	end

end

max = 0 
oversizelines.each do |num|
	if num > max 
		max = num
	end
end

puts max

