# require 'pry-byebug'





@sortingArray1 = []
@sortingArray2 = []
def merge_sort(array)
    # binding.pry

  if array.length < 2
    return
  else
    merge_sort(arrayLeft = array.slice(0, array.length/2))
    merge_sort(arrayRight = array.slice((array.length/2)..))
    # @sortingArray1 << merge(arrayLeft, arrayRight)
    # p @sortingArray1
  end

  # merging steps
  if @sortingArray2.length > 1

    while !@sortingArray2[0].empty? || !@sortingArray2[1].empty?
      begin
        if @sortingArray2[0][0] <= @sortingArray2[1][0]
          @sortingArray1 << @sortingArray2[0].shift
        else
          @sortingArray1 << @sortingArray2[1].shift
        end
      rescue
        @sortingArray1 = @sortingArray1 + @sortingArray2
        p @sortingArray1.flatten
        return
      end
    end

  end
  if arrayLeft[0] < arrayRight[0]
    @sortingArray1 << arrayLeft.shift
    @sortingArray1 << arrayRight.shift
  else
    @sortingArray1 << arrayRight.shift
    @sortingArray1 << arrayLeft.shift
  end
  @sortingArray2 << @sortingArray1
  @sortingArray1 = []

end


merge_sort([7, 3, 2, 1, 4, 8, 5])
# def merge(arr1, arr2)
#   sortingArray = []
#   while arr1.empty? == false && arr2.empty? == false
#     if arr1.first <= arr2.first
#       sortingArray << arr1.shift
#     else
#       sortingArray << arr2.shift
#     end
#   end
#   sortingArray = sortingArray + arr1 + arr2
#   sortingArray
# end
