# require 'pry-byebug'


@sortingArray = []
def merge_sort(array)
  # binding.pry
  if array.length < 2
    return
  else
    merge_sort(arrayLeft = array.slice(0, array.length/2))
    merge_sort(arrayRight = array.slice((array.length/2)..))
  end

  # merging steps
  if arrayLeft[0] < arrayRight[0]
    @sortingArray << arrayLeft[0]
    @sortingArray << arrayRight[0]
  else
    @sortingArray << arrayRight[0]
    @sortingArray << arrayLeft[0]
  end
  p @sortingArray
  # arrayLeft = sortingArray
end

merge_sort([7, 3, 2, 1, 4, 8, 5])
