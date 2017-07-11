#filereset

oldfile = IO.readlines("../../../patientfiles/genechunksdata/genechunklimitsdata_donorDONOR=DO217786.txt")
newfile = File.open("testdata.txt", "w")

oldfile.each do |line|
	newfile.syswrite(line)
end

