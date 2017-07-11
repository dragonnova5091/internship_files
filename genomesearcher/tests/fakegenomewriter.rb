#makes a fake genome

na = "atcg".split("")

file = File.open("fakegenome.txt", "w")



10000.times do 
	tempstring = ""
	100.times do 
		num = rand(0..3)
		tempstring += na[num]
	end
	#tempstring += "\n"
	file.syswrite(tempstring)
end



