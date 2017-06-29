#donor count
#counts the number of donors in the file
#require_realative 'patientfilewriter.rb'


class Donors
  attr_reader :donors
  def initialize
    @donors = []
  end

  def count(filename)
    get_lines(filename)
  end

  def get_lines(filename)
    #loops through the file 1000 lines at a time
    a = 1
    File.open(filename).each_slice(1000){|l1000|
      #puts a
      a += 1

      l1000.each do |line|
        donor = findDonor(line)
        if checkDouble(@donors, donor)
          @donors << donor
        end
      end
    }

  end

  def findDonor(line) #returns a string -- the donor number --
    #takes the line of data and collects the donor number
    part = nil
    donor = nil
    line = line.split("\t")
    line.each do |lin|
      if lin.include?("DONOR")
        part = lin.split(",")
      end
    end
      part.each do |bit|
        if bit.include?("DONOR")
          donor = bit
        end
      end
      #print donor
      return donor
  end

  def checkDouble(array, part) #returns a boolean
    #checks the array for a copy of the part
    decision = true
    array.each do |line|
      if line.to_s == part.to_s
        decision = false
      end
    end
    return decision
  end


end


#program = Donors.new
#print program.donors
#print program.donors.length
