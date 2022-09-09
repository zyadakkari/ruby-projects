require 'pry-byebug'


# @sortingArray2 = []
def merge_sort(array)
    # binding.pry

  if array.length < 2
    return array
  else
    left = merge_sort(array.slice(0, array.length/2))
    right = merge_sort(array.slice((array.length/2)..))
    merge(left, right)
  end
end


def merge(left, right, arr=[])
# binding.pry
    until left.empty? && right.empty?
      if left.empty?
        return arr + right
      elsif right.empty?
        return arr + left
      elsif left[0] <= right[0]
        arr << left.shift
      else
        arr << right.shift
      end
  end
  arr
end
p merge_sort([7, 3, 1])








#   p @sortingArray2 << @sortingArray1
#   @sortingArray1 = []
#
#
#   if @sortingArray2.length > 1
#
#     while !@sortingArray2[0].empty? || !@sortingArray2[1].empty?
#       begin
#         if @sortingArray2[0][0] <= @sortingArray2[1][0]
#           @sortingArray1 << @sortingArray2[0].shift
#         else
#           @sortingArray1 << @sortingArray2[1].shift
#         end
#       rescue
#         @sortingArray1 = @sortingArray1 + @sortingArray2
#         @sortingArray1.flatten
#         return
#       end
#     end
#   end
# end

#
# merge_sort([7, 1, 3, 5, 0, 2])
# # def merge(arr1, arr2)
# #   sortingArray = []
# #   while arr1.empty? == false && arr2.empty? == false
# #     if arr1.first <= arr2.first
# #       sortingArray << arr1.shift
# #     else
# #       sortingArray << arr2.shift
# #     end
# #   end
# #   sortingArray = sortingArray + arr1 + arr2
# #   sortingArray
# # end
