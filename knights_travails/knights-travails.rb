require 'pry-byebug'

class Board

  attr_accessor :board, :root, :counter, :moves

  def initialize(n, val=nil)
    @root = root
    @counter = 0
    @board = []
    @squares = []
    n.times do |row_index|
      row = []
      n.times { |column_index| row << val }
      @board << row
    end
  end

  def display_board()
    for i in (0..@board.length)
      p @board[i]
    end
  end

  def edit_board(x, y)
    if x.between?(0, 7) && y.between?(0, 7)
      @board[x][y] = 'knight'
    else
     puts 'Illegal position, please only choose numbers between 0 - 7'
    end
  end

  def build_tree(position, target, parent='origin')
# binding.pry
    @counter += 1
    rootNode = Knight.new(position, parent)
    address = rootNode
    if rootNode.moves.include?(target) || @counter > 500
      for i in (0..rootNode.moves.length-1)
        rootNode.moves[i] = Knight.new(rootNode.moves[i], address)
      end
      return rootNode
    else
      for i in (0..rootNode.moves.length-1)
        rootNode.moves[i] = build_tree(rootNode.moves[i], target, address)
      end
    end
      return @root = rootNode
  end
    # binding.pry

  def level_order_search(root, queue=[], target)
      # binding.pry
    queue << root
    while !queue.empty?
      begin
        @squares << queue[0].position
        if queue[0].position == target
          return queue[0]
        end
      rescue
        @squares << queue[0]
        # if queue[0] == target
        #   return queue[0].parent
        # end
      end
      begin
        for i in (0..queue[0].moves.length-1)
          queue << queue[0].moves[i]
        end
      rescue
      end
      queue.shift
      queue = queue.compact
    end
  end

  def knight_moves(root, target)
# binding.pry
    path = []
    node = level_order_search(root, queue=[], target)
    while node.parent != 'origin'
      path << node.position
      node = node.parent
    end
    path << node.position
    p path.reverse
  end

  class Knight
    attr_accessor :position, :moves, :parent

    def initialize(position, parent='origin')
      @position = position
      legal_positions(position)
      @parent = parent
    end

    def legal_positions(position)
      @moves = []
      x = [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]
      x.each do |val|
        move = [position[0] + val[0], position[1] + val[1]]
        if move[0].between?(0,7) && move[1].between?(0,7)
          @moves << move
        end
      end
      @moves
    end
  end
end

newBoard = Board.new(8)
newBoard.build_tree([0,0], [1, 1])
newBoard.knight_moves(newBoard.root, [1, 1])
