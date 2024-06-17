# frozen_string_literal: true

# player class that only has methods that insert letters a-z
class Player
  def player_choice
    puts 'Please choose 1 letter, upper or lowercase'
    input = gets.chomp
    if input.match?(/[a-z]/i) && input.length == 1
      input.downcase
    elsif input.match?(/save/i) && input.length > 1
      puts 'save attempt'
      input
    else
      player_choice
    end
  end

  def player_confirmation_input
    puts 'Do you want to open a saved file? Y/N'
    answer = gets.chomp
    if answer.match?(/y|n/i)
      answer
    else
      player_confirmation_input
    end
  end

  def player_number_input(total_files)
    puts "Please choose a number from #{total_files}"
    num_range = Array(0..total_files)
    num = gets.chomp.to_i
    puts "range check: #{num_range}" # for testing
    puts "include? #{num_range.include?(num)}" # for testing
    if num_range.include?(num)
      num
    else
      player_number_input
    end
  end
end
