require 'json'

module JSONable
  def to_json()
    instVars = {}
    self.instance_variables.each do |var|
      instVars[var] = self.instance_variable_get(var)
    end
    instVars.to_json
  end

  def from_json!()
    reloadedJSON = File.open("hangman.json")
    JSON.load(reloadedJSON).each do |var, val|
      self.instance_variable_set var, val
    end
  end
end

module Savable
  def save_game
    json_string = self.to_json
    File.open("hangman.json", "w") { |f| f.puts json_string}
  end
end


module WordPicker
  def pick_word
      dictionary = open("worddict.txt", "r")
      contents = dictionary.read.split.to_a
      validWords = contents.select { |word| word.length.between?(5, 12) }
      p @word = validWords.sample
  end
end

module WordPreparer
  def word_splitter
    @wordArray = @word.split("")
  end
end

module WordGuesser
  def takes_guess
    p @guessHolder
    puts "Please guess a letter or the full word: "
    @guess = gets.chomp.downcase
    puts "You guessed: #{@guess}"
  end
  def compare_full_word_guesses
    if @guess == @word
      puts "Thats right! You win!"
      @winner = true

    else
      puts "That's not the right word. You lose a life"
      @lives -= 1
    end
  end
  def compare_letter_guess
    if @wordArray.include? @guess
      puts "Thats right!"
      for i in (0..@wordArray.length)
        if @wordArray[i] == @guess
          @guessHolder[i] = @guess
        end
      end
    else
      puts "Wrong guess! You lose a life! :("
      @wrongGuesses.push(@guess)
      @lives -= 1
    end
  end
end


class Hangman
  include JSONable
  include Savable
  include WordPicker
  include WordPreparer
  include WordGuesser

  attr_accessor :name, :wrongGuesses, :winner, :lives, :guessHolder, :word

  def initialize()
    puts "Welcome to Hangman! Enter \'n\' to start a new game or \'r\' to reload: "
    reload = gets.chomp
    if reload == 'r'
      from_json!()
    else
      puts "What's your name? "
      @name = gets.chomp
      @wrongGuesses = Array.new()
      @winner = false
      @lives = 8
      pick_word()
      word_splitter()
      @guessHolder = Array.new(@word.length, '_')
    end
  end

  def play_game()
    while @winner == false && @lives != 0
      puts "Enter \'save\' to save and quit game. Enter any other key to continue"
      @save = gets.chomp
      if @save == "save"
        save_game()
        return
      end
      takes_guess()
      if @guess.length > 1
        compare_full_word_guesses()
      else
        compare_letter_guess()
      end
      puts "Letters used: #{@wrongGuesses}"
      puts "Lives left: #{@lives}"
    end
  end

end



newgame = Hangman.new()
newgame.play_game()
