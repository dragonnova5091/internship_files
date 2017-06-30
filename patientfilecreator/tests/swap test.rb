#swap test
def bubbleSort(array, bit) #needs a two part array [[1,2],[3,4]...]

  sorted = false
  while sorted == false
    sorted = true
    i = 0
    array.each do
      if i < (array.length-1)
        if array[i][bit] > array[i+1][bit]
          #switch the two values if the first is bigger than the second
          array[i],array[i+1] = array[i+1],array[i]
          sorted = false
        end
        i+=1
      end
    end
  end
  print array
end




arr = [[12,4],[7,8],[5,6],[2,3],[1,10],[8,9],[6,7]]
bubbleSort(arr, 1)
