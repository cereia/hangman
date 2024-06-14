# frozen_string_literal: true

# player class that only has methods that insert letters a-z
class Player
  def letter_choice
    puts 'Please choose 1 letter, upper or lowercase'
    letter = gets.chomp
    if letter.match?(/[a-z]/i) && letter.length == 1
      letter.downcase
    else
      letter_choice
    end
  end
end
