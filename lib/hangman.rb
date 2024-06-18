# frozen_string_literal: true

# game start: check if there are any saved games
#  yes: ask player if they want to play a saved file
#    yes: open saved file. if more than one, ask player which one => output list of files
#    no: start new game
#  no: start a new game

# game:
#   new word gets chosen as secret word
#   show an obscured version of secret word with length to user
#   have max wrong guesses = 7
#   human player can save every round before they guess
#   human player can guess until:
#     they get the secret word
#     they have 7 wrong guesses
#   prevent player duplicating letters by checking against already used letters
#   if saved game is loaded and it's finished, delete file

# human:
#   guess letters a-z case insensitive

# hangman class holds all code relating to playing the game hangman
class Hangman
  include Files

  def initialize
    Dir.mkdir('saves') unless Dir.exist?('saves')
    @player = Player.new
    @secret_word = ''
    @guessed = ''
    @chosen_letter = ''
    @wrong_guesses = ''
    @num_of_wrong_guesses_left = 7
    @saved_file = false
    @file = ''
    check_if_save_file_exists
  end

  def check_if_save_file_exists
    if Dir.empty?('saves')
      create_new_game
    else
      answer = @player.player_confirmation_input
      answer.match?(/y/i) ? open_save_file : create_new_game
    end
    play_round
  end

  def create_new_game
    file_data = File.read('dictionary.txt').split
    @secret_word = file_data.reject { |word| word.length < 5 || word.length > 12 }.sample(1)[0]
    @guessed = @secret_word.gsub(/\w/,'_')
    puts "Your word is #{@guessed.count('_')} letters long: #{@guessed}"
    puts "This is the number of wrong guesses you have left: #{@num_of_wrong_guesses_left}"
  end

  def play_round
    if !@num_of_wrong_guesses_left.zero? && @secret_word != @guessed
      check_player_choice
    elsif @secret_word == @guessed
      puts 'Congrats! You won!'
      delete_save_file
    else
      puts "You lost :(\nThe correct word was #{@secret_word} and you got #{@guessed}"
      delete_save_file
    end
  end

  def check_player_choice
    choice = @player.player_choice
    @chosen_letter = choice if choice.length == 1
    choice.match?(/save/i) ? save_game : insert_chosen_letter
  end

  def find_all_indices_of_chosen_letter
    # returns:
    #   an array of indices that match the letter provided, or
    #   an empty array if no matches
    (0...@secret_word.length).find_all { |idx| @secret_word[idx] == @chosen_letter }
  end

  def insert_chosen_letter
    indices = find_all_indices_of_chosen_letter
    if indices.empty?
      @wrong_guesses += @chosen_letter
      @num_of_wrong_guesses_left = 7 - @wrong_guesses.length
    else
      indices.map { |idx| @guessed[idx] = @chosen_letter }
    end
    print_player_information
    play_round
  end

  def print_player_information
    puts "\n"
    puts "Here is your current word: #{@guessed}"
    puts "Here are your wrong guesses: #{@wrong_guesses}"
    puts "Here are how many wrong guesses you have left: #{@num_of_wrong_guesses_left}"
  end
end
