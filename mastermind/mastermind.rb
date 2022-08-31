module CodeGenerator
  def generate_random_code()
    @gameArray = 4.times.map { Random.rand(9) }
  end
end

module InputCollector
  def collect_user_input()
    puts "Please enter a guess (4 digits 0-9): "
    @guess = gets.split()
    @guess.map!(&:to_i)
    @numberOfGuesses += 1
  end
end

module Checker
  def exact_match_checker(guess)
    for i in (0..guess.length - 1)
      if guess[i] == @gameArray[i]
        @flags[i] = "Green"
      end
    end
  end

  def existence_match_checker()
    @flags
    @nilPositionsInFlags = @flags.each_index.select {|i| @flags[i] == nil}
    @remainingCodeToGuess = @gameArray.select.with_index {|_, index| @nilPositionsInFlags.include? index }
    @nonExactGuesses = @guess.select.with_index {|_, index| @nilPositionsInFlags.include? index }


    for i in @nilPositionsInFlags
        if @remainingCodeToGuess.include? @guess[i]
          @flags[i] = "White"
        end
    end
    # for i in (0..@flags.length - 1)
    #   if @flags[i] == nil
    #
    #     if @gameArray.include? @guess[i]
    #       @flags[i] = "White"
    #     end
    #   end
    # end
  end
end

module Winner
  def check_win()
    if @flags.all? "Green"
      @winner = true
      puts "You win! Well done!"
    end
  end
end

class Mastermind
  include CodeGenerator
  include InputCollector
  include Checker
  include Winner

  def initialize()
    puts "Welcome to Mastermind! What's your name? "
    @name = gets.chop
    @numberOfGuesses = 0
    @winner = false
    puts "Hello #{@name}. Let's play!"
    play()
  end

  def play()
    generate_random_code()
    while @winner == false do
        p @gameArray
        collect_user_input()
        @flags = Array.new(4)
        exact_match_checker(@guess)
        existence_match_checker()
        p @flags
        check_win()
    end

  end
end

game = Mastermind.new()



# DEV CODE

# def existence_match_checker()
#   @flags = ["Green", nil, nil, nil]
#   @guess = [1, 2, 3, 4]
#   @gameArray = [1, 3, 2, 5]
#
#   @nilFlags = @flags.each_index.select {|i| @flags[i] == nil}
#   @newgamenum = @gameArray.select.with_index {|_, index| @nilFlags.include? index }
#   @remainingguess = @guess.select.with_index {|_, index| @nilFlags.include? index }
#
#   for i in @nilFlags
#       if @newgamenum.include? @remainingguess[i]
#         @flags[i] = "White"
#       end
#   end
#   p @flags
#   end
# existence_match_checker()
