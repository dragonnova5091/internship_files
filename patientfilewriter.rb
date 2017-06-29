#write to patient file for genome sequences

class Writer
  attr_reader :donornumber
  def openDonorFile(donornumber)
    #records the donor number
    @donornumber = donornumber
    filename = "donor#{donornumber}.txt"

    #open the file or makes it if it doesnt exist
    begin
      @readDonorFile = IO.readlines("patientfiles/#{filename}")
      @donorFile = File.open("patientfiles/#{filename}", 'w')
    rescue
      @donorFile =File.new("patientfiles/#{filename}", "w")
    end
    @donorFile.syswrite("this is donor ##{donornumber}\n")
  end

  def removeDuplicates(array)
    #this was more complicated, but then i remembered the .uniq function
    nodoublesarray = array.uniq
    puts "removed duplicatess"
    return nodoublesarray
  end


  def write_mutations(array)
    wrotetimes = 0 #records howmany times the file was written to
    texttowrite = removeDuplicates(array) # essentially .uniq
    #puts texttowrite
    #puts "--=="
    texttowrite.each do |line|

      #if the line is for the donor, then write it into the corresponding file
      if line.include?(@donornumber)
        @donorFile.syswrite(line)
        wrotetimes += 1
      end

    end
    puts "wrote #{wrotetimes} times to #{@donornumber}"
  end

  def closeDonorFile
    @donorFile.close
  end

end

#writer = Writer.new
