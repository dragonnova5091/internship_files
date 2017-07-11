#Ethan Hunter
#this program writes a set of files formatted for the samtools application
#more detail is described below

require 'limit_fixing/limitfixer.rb'

# Limitwriter has three functions:
# => closelocationlocator
    # => finds all the mutations that would overlap when mapping the genomes close to each other
# => all_locations
    # => returns all the locations of each mutation in a large array
    # => more instructions and info is below
# => get limits
    # => very specific
    # => DO NOT change it, it only works the way it is and 
    # => should be kept the way it is. I made it to work closely
    # => with the other two functions. 
class Limitwriter 
  def initialize
    #nothing here yet
  end

  #gets the locations that are within 40 of each other
  #returns indexes of the file with locations on the chr close together
  # like this arr [[close1, close2], [close1, close2, close3], [close1, close2], etc.]
  def closelocationlocator(filelocationandname)
    file = IO.readlines(filelocationandname)
    ind1 = 0
    closetogether = []

    file.each do
      if ind1 < (file.length-2)
        line1 = file[ind1].split("\t")
        line2 = file[ind1+1].split("\t")
        
        if line1[0] == line2[0]
          
          if (line1[1].to_i - line2[1].to_i).abs < 75
            temp = [ind1, ind1+1]

            #if the next number is within range then keep adding
            ind2 = ind1 + 2
            line3 = file[ind2].split("\t")
            while (line2[1].to_i - line3[1].to_i).abs < 75 && ind2 < file.length-2
              temp << ind2
              line2 = file[ind2].split("\t")
              ind2 += 1
              line3 = file[ind2].split("\t")
            end

            closetogether << temp
          end
        end
        ind1+=1
      end
    end

    return closetogether
  end


  #returns an array of [closelocations and notcloselocations] each of which is an array
  #closelocations is an array of arrays
  #     each array is all the locations close together
  #notcloselocations is an array of locations
  def all_locations(filelocationandname)
    file = IO.readlines(filelocationandname)

    closeindexes = closelocationlocator(filelocationandname)

    notcloselocations = [] #regualr array
    closelocations = [] #arrays in array

    ind = 0
    file.each do
      isclose = false
      closeindexes.each do |arr|
        if arr.include?(ind)
          isclose = true

          temparr = []
          arr.each do |index|
            line = file[index].split("\t")
            str = "#{line[0]},#{line[1]}"
            temparr << str
          end

          closelocations << temparr
        end

      end
      closelocations.uniq


      if isclose == false
        line = file[ind].split("\t")
        str = "#{line[0]},#{line[1]}"
        notcloselocations << str
      end
      ind += 1
    end

    arr = [closelocations, notcloselocations]

    return arr
  end

  #input either one part of closelocations or one part of notcloselocations
  #returns string of chromosome,lowerlimit,upperlimit \t\n
  def get_limits(location)

   # 4
    begin
      location = location.split(",")

      lower = location[1].to_i - 20

      upper = location[1].to_i + 20
      arr = "#{location[0]},#{lower},#{upper}\t\n"

      return arr
    rescue
      temparr = []
      location.each do |place|
        place = place.split(",")
        @chro = place[0]

        temparr << place[1].to_i
      end

      lower = temparr[0] - 20
      upper = temparr[temparr.length-1] + 20
      arr = "#{@chro},#{lower},#{upper}\t\n"

      return arr
    end
  end #
end

class Filesorter
  def initialize      #nothing here yet
  end

  #sorts the array based on the index(bit)
  def bubbleSort(array, bit) #needs a two part array [[1,2],[3,4]...]

    sorted = false
    while sorted == false
      sorted = true
      i = 0
      array.each do
        if i < (array.length-1)
          if array[i][bit].to_i > array[i+1][bit].to_i
            #switch the two values if the first is bigger than the second
            array[i],array[i+1] = array[i+1],array[i]
            sorted = false
          end
          i+=1
        end
      end
    end
    #print array
    return array
  end

  def sort(filelocationandname)
    file = IO.readlines(filelocationandname)
    file = by_chromosome(file)
    #puts file
    file = by_placement(file)
    return file 
  end

  def by_chromosome(array)
    temparray = []
    array.each do |line|
      temparr = line.split(",")
      temparr[0] = chr_to_int(temparr[0])
      #puts temparr[0]
      # 2
      
      temparray << temparr
      #puts temparr[0]
    end

    temparray = bubbleSort(temparray,0)

    arr = []
    temparray.each do |temparr|
      temparr[0] = int_to_chr(temparr[0])
      temparr = temparr.join(",")
      arr << temparr
    end

    return arr
  end

  def by_placement(array)
    temparray = [] 
    #arr = []
    array.each do |line|
      temparr = line.split(",")
      temparr[1] = temparr[1].to_i
      #arr << temparr.shift(1)
      temparray << temparr 
    end
    temphash = {}
    temparray.each do |line|
      if temphash.has_key?(line[0])
        temphash[line[0]] << line
      else
        temphash[line[0]] =[]
        temphash[line[0]] << line 
      end
    end
    temphash.each do |key, arr|
      temphash[key] = bubbleSort(arr, 1)
    end

    temparray = [] 
    temphash.each do |key, arr|
      temparray << arr 
    end


    array = []
    temparray.each do |temparr|
      #ch = arr.shift
      #temparr = temparr.unshift(ch)
      temparr = temparr.join(",")
      #print temparr
      #sleep 5
      array << temparr
    end
    print array

    return array 
  end

  def chr_to_int(chro)
    case chro 
    when 'chr1'
      num = 1
    when 'chr2'
      num = 2
    when 'chr3'
      num = 3
    when 'chr4'
      num = 4
    when 'chr5'
      num = 5
    when 'chr6'
      num = 6
    when 'chr7'
      num = 7
    when 'chr8'
      num = 8
    when 'chr9'
      num = 9
    when 'chr10'
      num = 10
    when 'chr11'
      num = 11
    when 'chr12'
      num = 12
    when 'chr13'
      num = 13
    when 'chr14'
      num = 14
    when 'chr15'
      num = 15
    when 'chr16'
      num = 16
    when 'chr17'
      num = 17
    when 'chr18'
      num = 18
    when 'chr19'
      num = 19
    when 'chr20'
      num = 20
    when 'chr21'
      num = 21
    when 'chr22'
      num = 22
    when 'chrX'
      num = 23
    end
    return num 
  end

  def int_to_chr(num)
    case num
    when 1
      chro = 'chr1'
    when 2
      chro = 'chr2'
    when 3
      chro = 'chr3'
    when 4
      chro = 'chr4'
    when 5
      chro = 'chr5'
    when 6
      chro = 'chr6'
    when 7
      chro = 'chr7'
    when 8
      chro = 'chr8'
    when 9
      chro = 'chr9'
    when 10
      chro = 'chr10'
    when 11
      chro = 'chr11'
    when 12
      chro = 'chr12'
    when 13
      chro = 'chr13'
    when 14
      chro = 'chr14'
    when 15
      chro = 'chr15'
    when 16
      chro = 'chr16'
    when 17
      chro = 'chr17'
    when 18
      chro = 'chr18'
    when 19
      chro = 'chr19'
    when 20
      chro = 'chr20'
    when 21
      chro = 'chr21'
    when 22
      chro = 'chr22'
    when 23
      chro = 'chrX'
    end
    return chro 
  end
end


def step1
  master = Limitwriter.new #
  Dir.chdir("patientfiles")
  puts "looping through files"

  #open or creates a new folder/file: genechunksdata/genechunklimitsdata_donor#
  # => the files are formatted
      # => chr,lowerlimit,upperlimit
    # => the files will be updated in the next glob loop.
    # => I wanted to keep then separate to avoid 
    # => messing up the first one.

  #Voilá 
  Dir.glob("*.txt").each do |filename|
    puts "next file"
    array = master.all_locations("#{filename}")
    puts "have the locations"

    #gets the limits for each mutation genechunk
    all_limits = [] 
    array[0].each do |close|
      all_limits << master.get_limits(close)
    end
    array[1].each do |locat|
      all_limits << master.get_limits(locat)
    end

    puts "have the limits "

    #checks for the required directory and filenames, 
    # => if they are missing it creates them
    newfilename = "genechunklimitsdata_#{filename}"
    if Dir.exist?("genechunksdata") == false
      Dir.mkdir("genechunksdata")
      puts "made new directory"
      sleep 2
    end

    begin
      filewrite = File.open("genechunksdata/#{newfilename}", "w")
    rescue
      filewrite = File.new("genechunksdata/#{newfilename}")
    end

    #!all_limits.uniq

    #writes to the new file
    all_limits.each do |line|
      #line
      filewrite.syswrite(line)
    end

    puts "wrote to the file "

    filewrite.close

  end
end

def step2
  #puts Dir.pwd
  Dir.chdir("patientfiles/genechunksdata")

  lngth = Dir.glob("*.txt").length
  filenumber = 1

  #adds more data to the genechunksdata/genechunklimitsdata_donor# file
    # => formats it as such
      # => chr,lowerlimit,upperlimit  mutation_location,originalsequence,newsequence  'repeats
      # => for each mutation in the sequence'
  Dir.glob("*.txt") do |filename|
    puts "file: #{filenumber}/#{lngth}"
    filenumber+=1

    add_data = []

    #gets the data to add
    oldfilename = filename.split("_")
    #puts oldfilename
    donorfile = IO.readlines("../#{oldfilename[1]}")
    donorfile.each do |line|
      lin = line.split("\t")
      
      data = "#{lin[0]},#{lin[1]},#{lin[3]},#{lin[4]}\t"
      #puts data 
      # 2
      add_data << data 
    end
    puts "formatted the new data"
    
    #formats the line to write
    towrite = [] 
    newfile = IO.readlines(filename)
    newfile.each do |lin|
      line = lin.chomp
      
      add_data.each do |dat|
        data = dat.split(",")
        #puts lin
        splt = line.split(",")
       # puts "splt: #{splt}"
        #puts "data: #{data}"
        # 0.25
        if splt[1].to_i < data[1].to_i && splt[2].to_i > data[1].to_i && splt[0] == data[0]
          newdata = "#{lin.chomp}#{dat}\n"
         #puts newdata
          # 2
          towrite<<newdata
          #puts newdata
          # 2
        end
      end
    end
    puts "formatted the new file"

    #print towrite
    # 20

    #writes the file again
    puts filename
    #puts towrite.length
    # 5
    #puts IO.readlines("filename")
    file = File.open(filename, "w+")

    towrite.each do |linetowrite|
      
      file.syswrite(linetowrite)
      #puts "got here"
    end
    file.close 
    puts "wrote the new file"
    print "\n~~\n"
  end 
end

#sort tests

def step3
  #Dir.chdir("patientfiles/genechunksdata")

  lngth = Dir.glob("*.txt").length
  filenumber = 1 

  Dir.glob("*.txt").each do |filename|
    puts "file: #{filenumber}/#{lngth}"
    clear_blank_lines(filename)
    puts "formatting the next file"
    filenumber += 1
    fixer(filename)
    clear_blank_lines(filename)

    
    limit_fixer(filename)
  end


end


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

  #puts newfile
  writer = File.open(filename, "w")

  newfile.each do |line|
    writer.syswrite("#{line}\n")
  end
end

def clear_blank_lines(filename)
  file = IO.readlines(filename)

  newfile = []
  file.each do |line|
    if line.include?("chr")
      newfile << line 
    end
  end

  writer = File.open(filename, "w")
  newfile.each do |line|
    writer.syswrite(line)
  end
  puts "cleared blank lines "
end


step1
Dir.chdir("..")
step2 #step 2 take a good 80+ minutes to run on a normal computer, be careful
#Dir.chdir("patientfiles/genechunksdata") #use this line if step two is commented out, otherwise comment it
step3

