#to get the locations of the mutations

class Master
  def initialize
    #nothing here yet
  end

  #gets the locations that are within 40 of each other
  def closelocationlocator(filelocationandname)   # returns indexes of the file with
                                                  #locations that are close together
    file = IO.readlines(filelocationandname)
    ind1 = 0
    closetogether = []

    file.each do
      if ind1 < (file.length-2)
        line1 = file[ind1].split("\t")
        line2 = file[ind1+1].split("\t")
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
    return closetogether
  end

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
  end

  def get_limits(location)
    begin
      !location.split(",")
      lower = location[1].to_i - 20
      upper = location[1].to_i + 20
      arr = [location[0],lower, upper]
      return arr
    rescue
      temparr = []
      location.each do |place|
        !place.split(",")
        chr = place[0]
        temparr << place[1]
      end
      temparr.sort
      lower = temparr[0].to_i - 25
      upper = temparr[temparr.length-1].to_i +1
      arr = [chr, lower, upper]
      return arr
    end
  end
end
