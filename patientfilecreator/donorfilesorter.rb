#sorts through a single donor file
#sorted first by chromosome, then
#by mutation placement

class Sorter
    attr_reader :sortcard
  def initialize
    @sortcard = []
  end

  def open_file(filename)
    @patientFileRead = IO.readlines(filename)
    #@patientFileWrite = File.open(filename, 'w')
    #puts "opened"
  end

  def close_file
    #@patientFileWrite.close
  end

  def sort_by_chr
    index = 0
    @sortcard = []
    num = 1
    23.times do
      temparray = [nil, num]
      @sortcard << temparray
      num += 1
      #puts 'made sortcard'
    end
    @patientFileRead.each do |data|
      line = data.split("\t")
      if line[0].include?("chrX")
        num = 23
      else   
      #please ignore this obnoxious case statement. it is a sustitute for .to_i, as for some reason it doesnt work
        case line[0]
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
        end
      end
      #puts "split the line"
      !num.to_i
      a = 0
      @sortcard.each do
        if num == @sortcard[a][1]
          @sortcard[a] << index
        end
        a += 1
      end
      #puts "ran through the @sortcard"

      #sleep 10
      index += 1
    end
    #print @sortcard


    #makes a new array of the mutations sorted by chromosome number
    sortedbychromosome = []
    @sortcard.each do |type|
      index = 2
      (type.length-2).times do
        sortedbychromosome << @patientFileRead[type[index]]
        index += 1
      end
    end

    #return sortedbychromosome
    #puts sortedbychromosome
  end

  def sort_by_placement

    sortedbyplacement = []
    ind = 0
    @sortcard.each do |card| #each 'card' is the indexes of the lines for chromosome 1
      chr = []
      #puts "asdf#{card}--"
      !card.shift(2)
      card.each do |index|
        #puts "asdf#{index}--"
        place = find_placement(@patientFileRead[index])
        arr = [place, index]
        chr << arr
      end
      sortedbyplacement << bubbleSort(chr,0)
      #puts "---\n---\n---"
      #sleep 5
      #print chunk
      ind += 1
    end
    #print chunk
    #print sortedbyplacement
    return sortedbyplacement
  end

  def find_placement(line) #used only in sort_by_placement//returns the placement num
    arr = line.split("\t")
    if arr[1].include?(" ")
      a = arr[1].split(" ")
      num = a[0]
    else
      num = arr[1]
    end
    return num
  end

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
end
