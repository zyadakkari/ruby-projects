module Welcomer
 def welcome_message
   puts "============================"
   puts "============================"
   puts "=== Welcome to Mastermind!=="
   puts "============================"
   puts "============================"
   puts "\nHello! What's your name? "

 end
end

module RoleChooser
  def choose_roles(setter)
    if @roleSetter == "1"
      human_play()
    else
      comp_play()
    end
  end
end


module CodeGenerator
  def generate_random_code()
    4.times.map { Random.rand(9) }
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
  end
end

module CompGuessImprover
  def white_guess_finder
    @whiteFlags = @flags.each_index.select do |i|
      if @flags[i] == "White"
        @guess[i]
      end
    end
  end
  def guess_improver
    @flags
    @flags.each_index.select do |i|
      if @flags[i] == "White" && @whiteFlags.length > 1
        if @whiteFlags[0] == @guess[i]
          @guess[i] = @whiteFlags[1]
          @whiteFlags.splice(1,1)
        else
          @guess[i] = @whiteFlags[0]
          @whiteFlags.shift
        end
      elsif @flags[i] == "White"
        @guess[i] = @availableNumToGuess[Random.rand(@availableNumToGuess.length)]
      elsif @flags[i] == nil
        @guess[i]
        # p @availableNumToGuess(@guess[i])
        @availableNumToGuess.delete(@guess[i])
        if @whiteFlags.length >= 1
          @guess[i] = @whiteFlags[0]
          @whiteFlags.shift
        else
          @availableNumToGuess.length
          @availableNumToGuess
          @guess[i] = @availableNumToGuess[Random.rand(@availableNumToGuess.length)]
        end
      end
    end
  @guess
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
  include Welcomer
  include RoleChooser
  include CodeGenerator
  include InputCollector
  include Checker
  include Winner
  include CompGuessImprover

  def initialize()
    welcome_message()
    @name = gets.chop
    @numberOfGuesses = 0
    @winner = false
    puts "Hello #{@name}. Let's play! Would you like to guess or create the code. Type 1 for guess and 2 for create"
    @roleSetter = gets.chop
    choose_roles(@roleSetter)
  end
  def code_checker(guess)
    exact_match_checker(guess)
    existence_match_checker()
  end
  def human_play()
    @gameArray = generate_random_code()
    while @winner == false do
        # p @gameArray
        collect_user_input()
        @flags = Array.new(4)
        code_checker(@guess)
        p @flags
        check_win()
    end
  end
  def comp_play()
    @availableNumToGuess = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    puts "Please enter a 4 digit code for the computer to guess: "
    @gameArray = gets.split()
    @gameArray.map!(&:to_i)
    @guess = generate_random_code()
    while @winner == false do
      p @guess
      @flags = Array.new(4)
      code_checker(@guess)
      white_guess_finder()
      guess_improver()
      check_win()
      sleep 2
    end
  end
end


game = Mastermind.new()
