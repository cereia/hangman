# frozen_string_literal: true

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

  private

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
    elsif @secret_word == @guessed || @num_of_wrong_guesses_left.zero?
      puts 'Congrats! You won!' if @secret_word == @guessed
      puts "You lost :(\nThe word was #{@secret_word} and you got #{@guessed}" if @num_of_wrong_guesses_left.zero?
      delete_save_file
      replay
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

  def replay
    puts 'Would you like to play again?'
    answer = @player.player_confirmation_input
    if answer.match?(/y/i)
      Hangman.new
    else
      puts 'Thank you for playing!'
    end
  end
end
