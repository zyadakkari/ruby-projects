# INSERT WORKS PERFECTLY - BUT PROBLEM IS THAT
# LAST NODES IN THE TREE ARE ARRAYS NOT VALUES



require 'pry-byebug'

class Tree

  attr_accessor :root

  def initialize(array)
    @array = array
    @root = root
    @values = []
    @height = 0

  end
# build tree pseudocode:
# split array in two to find the middle, create node of middle
# set l/r as the call recursive tree builder for the l/r subarrays -> node mid
# create base condition of subarray len = 1. when true create node
# and return the node
  def build_tree(array)
    array = array.sort.uniq
    if array.length < 2
      if array.empty?
        return nil
      end
      return Node.new(array[0])
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

  def find(value, root)
    if root.data == value
      return root
    elsif root.data < value
      find(value, root.right)
    elsif root.data > value
      find(value, root.left)
    else
      puts "Could not find the value in this tree"
    end
  end

  def find_min(root)
    while !root.left.nil?
      root = root.left
    end
    min = root
  end

  def insert(value, root)
    if root.nil?
      return self.root = Node.new(value)
    elsif root.data == value
      puts "Number already in tree"
      return
    elsif root.data < value
      if root.right.nil?
        root.right = Node.new(value)
      else
      insert(value, root.right)
      end
    elsif root.data > value
      if root.left.nil?
        root.left = Node.new(value)
      else
        insert(value, root.left)
      end
    end
  end


  def delete_node(value, root)
    # binding.pry
    if root.nil?
      return root
    elsif value < root.data
      root.left = delete_node(value, root.left)
      return root
    elsif  value > root.data
      root.right = delete_node(value, root.right)
      return root
    else
      if root.left.nil? && root.right.nil?
        root = nil
      elsif root.left.nil?
        root = root.right
      elsif root.right.nil?
        root = root.left
      else
        # binding.pry
        min = find_min(root.right)
        root.data = min.data
        root.right = delete_node(min.data, root.right)
      end
      return root
    end
  end

  def level_order(root, queue=[])
    queue << root
    while !queue.empty?
      @values << queue[0].data
      queue << queue[0].left
      queue << queue[0].right
      queue.shift
      queue = queue.compact
    end
    @values
    yield if block_given?
  end

  def preorder(root)
     # binding.pry
    if root.nil?
        return
    else
      @values << root.data
      preorder(root.left)
      preorder(root.right)
    end
    @values
  end

  def postorder(root)
    if root.nil?
      return
    else
      postorder(root.left)
      postorder(root.right)
    end
    @values << root.data
  end

  def inorder(root)
    if root.nil?
      return
    else
      inorder(root.left)
      @values << root.data
      inorder(root.right)
    end
    @values
  end

  def find_height(node)
    if node.nil?
      return -1
    else
      heightLeft = find_height(node.left)
      heightRight = find_height(node.right)
      heightLeft >= heightRight ? heightLeft + 1 : heightRight + 1
    end
  end

  def find_depth(value, root)
    if root.nil?
      puts "This number does not exist in this tree"
      exit()
    elsif value == root.data
      return 0
    elsif value > root.data
      depth = find_depth(value, root.right)
      depth += 1
    elsif value < root.data
      depth = find_depth(value, root.left)
      depth += 1
    else return
    end
    depth
  end

  def balanced?(root)
    # binding.pry
    @values = []
    level_order(root)
    revValues = @values.reverse
    while revValues.length > 1
      a = find_height(find(revValues[0], root))
      b = find_height(find(revValues[1], root))
      if !(a-b).between?(-1, 1)
        puts 'Tree is unbalanced'
        return
      else
        2.times {revValues.shift}
      end
    end
    puts 'Tree is balanced'
  end

  def rebalance(root)
    @values = []
    preorder(root)
    build_tree(@values)
  end

  class Node
    include Comparable

    attr_accessor :data, :left, :right

    def <=>(other)
      data <=> data
    end

    def initialize(data=nil, left=nil, right=nil)
      @data = data
      @left = left
      @right = right
    end
  end
end


array = Array.new(15) { rand(1..100) }
newTree = Tree.new(array)
newTree.build_tree(array)
newTree.balanced?(newTree.root)
p newTree.preorder(newTree.root)
newTree.insert(120, newTree.root)
newTree.insert(130, newTree.root)
newTree.balanced?(newTree.root)
newTree.rebalance(newTree.root)
newTree.balanced?(newTree.root)
