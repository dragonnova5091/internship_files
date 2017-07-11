#goes through a set genome and takes the location and changes it to an abnormal genome


lim1 = rand(100..999000)
lim2 = lim1 + 41


file = IO.readlines("fakegenome.txt")

file = file[0].split("")

chunk = file[lim1..lim2]

chunk.join("")!


file = IO.readlines("../..patientfiles/genechunksdata/genechunklimitsdata_donorDONOR=DO217786.txt")

#chr6,18559753,18559794	chr6,18559773,CAAG,CCA	chr6,18559774,A,C
line = file[11]

line.split("\t")!
change = line[1].split(",")

ori = change[2]
abn = change[3]



