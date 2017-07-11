#resetfile


small = File.open("test_genechunklimitsdata.txt", "w")

File.open("../../patientfiles/genechunksdata/genechunklimitsdata_donorDONOR=DO217786.txt"){|line|
	2000.times do 
		small.syswrite(line.gets)
	end
}

