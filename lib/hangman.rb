# frozen_string_literal: true

# hangman class holds all code relating to playing the game hangman
class Hangman
  def initialize
    Dir.mkdir('saves') unless Dir.exist?('saves')
    @secret_word = ''
    @guessed = ''
    @wrong_guesses = ''
    @num_of_wrong_guesses_left = 7
    check_if_save_file_exists
  end

  def check_if_save_file_exists
    if Dir.empty?('saves')
      file_data = File.read('dictionary.txt').split
      @secret_word = file_data.reject { |word| word.length < 5 || word.length > 12 }.sample(1)
      @guessed = @secret_word.to_s.gsub(/\w/,'_').to_s
      puts "Your word is #{@guessed.count('_')} letters long: #{@guessed}"
      puts "This is the number of wrong guesses you have left: #{@num_of_wrong_guesses_left}"
    else
      puts 'Do you want to open a saved file?'
    end
  end
end
