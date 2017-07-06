#to get the locations of the mutations

class Master
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
        #print line1 
        #sleep 10
        if line1[0] == line2[0]
          
          if (line1[1].to_i - line2[1].to_i).abs < 40
            temp = [ind1, ind1+1]

            #if the next number is within range then keep adding
            ind2 = ind1 + 2
            line3 = file[ind2].split("\t")
            while (line2[1].to_i - line3[1].to_i).abs < 40
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
    #print closetogether
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
    #print arr
    return arr
  end

  #input either one part of closelocations or one part of notcloselocations
  def get_limits(location) #returns array of [chromosome, lowerlimit, upperlimit]
    #print "!!#{location}  "
    sleep 4
    begin
      !location.split(",")
      lower = location[1].to_i - 20
      #print location[1]
      #print "~~  "
      #sleep 4
      upper = location[1].to_i + 20
      arr = [location[0],lower, upper]
      return arr
    rescue
      temparr = []
      location.each do |place|
        place = place.split(",")
        @chro = place[0]
        #print @chro
        sleep 0.5
        print place[1].to_i
        temparr << place[1].to_i
      end
      #print "~"
      #temparr.sort
      lower = temparr[0] - 20
      upper = temparr[temparr.length-1] + 20
      arr = [@chro, lower, upper]
      #print "@#{arr}~ "
      return arr
    end
  end
end

master = Master.new
Dir.chdir("../patientfiles")
Dir.glob("*.txt").each do |filename|
  array = master.all_locations("../patientfiles/#{filename}")
  #puts filename

  array[0].each do |close|
    #print close
    #print "@#~"
   # sleep 2
    master.get_limits(close)
  end
  array[1].each do |locat|
    master.get_limits(locat)
  end

end
