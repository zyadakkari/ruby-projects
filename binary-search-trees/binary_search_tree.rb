require 'pry-byebug'

class Tree

  attr_accessor :root

  def initialize(array)
    @array = array
    @root = root

  end
# build tree pseudocode:
# split array in two to find the middle, create node of middle
# set l/r as the call recursive tree builder for the l/r subarrays -> node mid
# create base condition of subarray len = 1. when true create node
# and return the node
  def build_tree(array)
# binding.pry
    # sortedArray = array.sort.uniq
    array = array.sort.uniq
    if array.length < 2
      if array.empty?
        return nil
      end
      return Node.new(array)
    else
      root = array[array.length/2.floor]
      rootNode = Node.new(root)
      rootNode.left = build_tree(array[..array.length/2-1])
      rootNode.right = build_tree(array[array.length/2+1..])
    end
    return @root = rootNode
  end

  def pretty_print(rootNode = @root, prefix = '', is_left = true)
  pretty_print(rootNode.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if rootNode.right
  puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{rootNode.data}"
  pretty_print(rootNode.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if rootNode.left
end

  class Node
    include Comparable

    attr_accessor :data, :left, :right

    def <=>(other)
      data <=> other.data
    end

    def initialize(data=nil, left=nil, right=nil)
      @data = data
      @left = left
      @right = right
    end
  end
end

newTree = Tree.new([1, 2, 3])
p newTree.build_tree([1, 1, 2, 3, 3, 19, 4, 6, 7, 8, 9, 13])

newTree.pretty_print()
