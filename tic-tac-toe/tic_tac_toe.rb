module CreateBoard
  def create_board()
    @board = [%w(A1 A2 A3)] + [%w(B1 B2 B3)] + [%w(C1 C2 C3)]
  end
end

module CreatePlayer1
  def player_one(name="player one")
    @name = name
    @symbolone = 'X'
  end
end

module CreatePlayer2
  def player_two(name="player two")
    @name = name
    @symboltwo = 'O'
  end
end

module GetInput
  def get_input
    @turnnumb += 1
    if @turnnumb.to_f % 2 != 0
      puts "Your turn player 1, pick your square"
    else puts "Your turn player 2, pick your square"
    end
    @input = gets.chop.upcase
  end
end

module EditBoard
  def edit_board()
    if @turnnumb.to_f % 2 != 0
      for array in @board do
        array.map! { |x| x == @input ? "X" : x}
       end
    else
        for array in @board do
          array.map! { |x| x == @input ? "O" : x}
         end
    end
  end
end

module ShowBoard
  def show_board
    p @board[0]
    p @board[1]
    p @board[2]
  end
end

module Tie
  def tie()
    freePositions = %w[A1 A2 A3 B1 B2 B3 C1 C2 C3]
    combinedArray = @board.flatten
    if (freePositions & combinedArray).empty?
        puts "It's a draw!"
        @tie = true
    end
  end
end

# checks winner by row
module FindWinner
    def row_all_same?(array)
        array.uniq.count <= 1
    end

    def check_if_row_winner(array)
        for arr in array do
            if row_all_same?(arr)
                winningplayer = arr[0]
                if winningplayer == "X"
                    winningplayer = "player1"
                else winningplayer = "player 2"
                end
                p "we have a winner, #{winningplayer}"
                @winner = winningplayer

            end
        end
    end

    # checks winner by column
    def change_columns_to_rows(array)
        @widercheck = []
        for i in (0..2) do
            checkarray = []
            for arr in array do
                checkarray.push(arr[i])
            end
            @widercheck.push(checkarray)
        end
        @widercheck
    end

    def diagonals_to_row(array)
        @diagonalArraysList = []
        @diagonalArray = []
        for i in (0..(@board.length - 1)) do
          @diagonalArray.push(array[i][i])
        end
        @reverseDiagonalArray = []
        for i in (0..(@board.length - 1))
          @reverseDiagonalArray.push(@board[i][(@board.length - 1)-i])
        end
        @diagonalArraysList.push(@diagonalArray)
        @diagonalArraysList.push(@reverseDiagonalArray)
        @diagonalArraysList
    end

    def winner?(board)
        if @turnnumb >= 5
          check_if_row_winner(board)
          change_columns_to_rows(board)
          check_if_row_winner(@widercheck)
          diagonals_to_row(board)
          check_if_row_winner(@diagonalArraysList)

        end
    end
end





class Game
  include CreateBoard
  include CreatePlayer1
  include CreatePlayer2
  include GetInput
  include ShowBoard
  include EditBoard
  include FindWinner
  include Tie
  def initialize()
    @turnnumb = 0
    @tie = false
    @winner = false
  end

  def play_game()
    player_one()
    player_two()
    puts "Let's play tic-tac-toe!"
    create_board()
    show_board()
    while @tie == false && @winner == false
      get_input()
      edit_board()
      show_board()
      tie()
      winner?(@board)
    end
  end
  def winner()
  end
end


game = Game.new()
game.play_game()
