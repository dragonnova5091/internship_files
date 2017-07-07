#master file
#calls the functions from the others

Dir["./patientfilecreator/*.rb"].each { |file| require file }

#checks for the directory "patientfiles" then makes one if it doesn't exist
if File.directory?("patientfiles") == false
  Dir.mkdir "patientfiles"
  puts "made new dir"
end

########READ THE NEXT 3 LINES!!!##########
datafile = "smalldata.txt"
#the next line is for whatever other file you would rather use.
#datafile =
##########################################

#makes the neccessary objects
donorcounter = Donors.new
filewriter = Writer.new
mutationsorter = Sorter.new
#puts filewriter.donornumber
puts "starting to work"

filenames = []

#im using a test file with only 50,000 lines intead of 12 million. the
#original file is -- simple_somatic_mutation.open.BRCA-EU.vcf -- . this is
#just for convinence.


#
#loops through each donor and then puts each line of data that includes
#the id of the donor into a file labeled by the id

#the files are located in patientfiles/~filename~
donorcounter.count(datafile)
donorcounter.donors.each do |donor|
  filewriter.openDonorFile(donor)
  filenames << "patientfiles/donor#{donor}.txt"

  puts "going to sort through the data"
  #goes through the data 10,000 lines at a time to avoid crashing the ram
  File.open(datafile).each_slice(10000){|l1000|
    #print l1000
    filewriter.write_mutations(l1000)
  }
  puts 'finished writing'
  #filewriter.closeDonorFile
end

#creates a Hash to hold all teh data
totalDataHash = Hash.new
filenames.each do |name|
  totalDataHash[name] = nil
end

#sorts through the patientfiles individually and sorts them, first
#by chromosome, then by spacing.
filenames.each do |name|
  mutationsorter.open_file(name)
  mutationsorter.sort_by_chr
  sortedArray = mutationsorter.sort_by_placement
  puts "sorted by chromosome then by location"
  #array is [[location on genome, index in the file], [","], etc]


  totalDataHash[name] = sortedArray
  #puts sortedArrayByChromosome
  mutationsorter.close_file


end

#take the sorted indexes, and change it to actual data
filenames.each do |name|
  readfile = IO.readlines("#{name}")

  sorteddata = []
  totalDataHash[name].each do |arr|
    #print arr
    #sleep 10
    #print "\n\n\n"
    arr.each do |twobit|
      #puts twobit[1]
      sorteddata << readfile[twobit[1]]
    end
  end
  #puts sorteddata
  #puts "\n\t-----"
  puts "have the completely sorted data"

  #totalDataHash[name] is now the data needed to write into the ~name~ file
  totalDataHash[name] = sorteddata


  file = File.open(name, "w")
  totalDataHash[name].each do |line|
    file.syswrite(line)
  end
  file.close
end



#the end
puts "stopping now"
exit
