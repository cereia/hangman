# frozen_string_literal: true

# player class that only has methods that insert letters a-z
class Player
  def initialize
    @guessed_letters = ''
  end

  def player_choice
    puts 'Please choose 1 letter, upper or lowercase'
    input = gets.chomp.downcase
    if input.match?(/[a-z]/) && input.length == 1 && !@guessed_letters.include?(input)
      @guessed_letters += input
      input
    elsif input.match?(/save/)
      input
    else
      player_choice
    end
  end

  def player_confirmation_input
    puts 'Do you want to open a saved file? Y/N' unless Dir.empty?('saves')
    answer = gets.chomp
    if answer.match?(/y|n/i)
      answer
    else
      player_confirmation_input
    end
  end

  def player_number_input(total_files)
    puts "Please choose a number from 0 to #{total_files}"
    num_range = Array(0..total_files)
    num = gets.chomp.to_i
    if num_range.include?(num)
      num
    else
      player_number_input(total_files)
    end
  end
end
