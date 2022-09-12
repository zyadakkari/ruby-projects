class LinkedList
  attr_accessor :head

  def initialize
    self.head = nil
  end

  def get_head()
  # gets the first node, but includes the other nodes within nextNode var
    self.head
  end

  def get_tail()
    if self.head.nil?
      tail = nil
    else
      lastNode = self.head
      while (!lastNode.nextNode.nil?)
        lastNode = lastNode.nextNode
      end
      lastNode
    end
  end

  def append(value)
    if self.head.nil?
      self.head = Node.new(value, nil)
    else
      lastNode = self.head
      while (!lastNode.nextNode.nil?)
        lastNode = lastNode.nextNode
      end
      lastNode.nextNode = Node.new(value, nil)
    end
  end

  def prepend(value)
    lastNode = self.head
    self.head = Node.new(value, nil)
    self.head.nextNode = lastNode
  end

  def size()
    count = 1
    lastNode = self.head
    while (!lastNode.nextNode.nil?)
      lastNode = lastNode.nextNode
      count += 1
    end
    count
  end

  def at(index)
    lastNode = self.head
    for i in (1..index)
      lastNode = lastNode.nextNode
    end
    lastNode
  end

  def pop()
    varToRemove = self.size() - 2
    self.at(varToRemove).nextNode = nil
  end

  def contains?(value)
    if self.head.nil?
      return false
    elsif self.head.value == value
      return true
    else
      lastNode = self.head
      while (!lastNode.nextNode.nil?)
        lastNode = lastNode.nextNode
        if lastNode.value == value
          return true
        end
      end
      return false
    end
  end

  def find(value)
    helperIndex = 0
      if self.head.value == value
        return helperIndex
      else
        lastNode = self.head

        while (!lastNode.nextNode.nil?)
          helperIndex += 1
          lastNode = lastNode.nextNode
          if lastNode.value == value
            return helperIndex
          end
        end
      end
  end

  def to_s()
    values = []
    values << self.head.value
    lastNode = self.head
    while (!lastNode.nextNode.nil?)
      lastNode = lastNode.nextNode
      values << lastNode.value
    end
    p values.join(' -> ')
  end


  def insert_at(value, index)
    lastNode = self.at(index)
    savedNextNode = lastNode.nextNode
    lastNode.nextNode = Node.new(value, nil)
    lastNode.nextNode.nextNode = savedNextNode
  end

  def remove_at(index)
    nodeToRemove = self.at(index)
    if nodeToRemove.nextNode.nil?
      self.pop()
    else
      savedNodes = nodeToRemove.nextNode
      self.at(index - 1).nextNode = savedNodes
    end
  end

  class Node
    attr_accessor :value, :nextNode

    def initialize(value, nextnode)
      self.value = value
      self.nextNode = nextNode
    end
  end
end


newList = LinkedList.new()
newList.append('first')
newList.append('second')
newList.prepend('newfirst')
newList.prepend('hello')
newList.remove_at(2)
p newList
