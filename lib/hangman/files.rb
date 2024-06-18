# frozen_string_literal: true

# File save, load, and delete
module Files
  def open_save_file
    save_files = Dir.entries('saves').reject { |f| File.directory? f }
    if save_files.length > 1
      save_files.each_with_index { |f, i| puts "#{i}: #{f}" }
      num = @player.player_number_input(save_files.length - 1)
      @file = save_files[num]
    else
      @file = save_files[0]
    end
    from_yaml
    print_player_information
  end

  def delete_save_file
    return unless @saved_file == true

    puts "\n"
    puts 'That was the end of this hangman game! This file will now be deleted...'
    File.delete(@file)
    puts '...and it\'s gone :)'
  end

  def save_game
    @file = "saves/#{@guessed.length}_letters_#{('a'..'z').to_a.sample(8).join}.yml" if @file.empty?
    @saved_file = true
    save_file = to_yaml
    File.open(@file, 'w') do |file|
      file.puts save_file
    end
  end

  def to_yaml
    YAML.dump({
                secret_word: @secret_word,
                guessed: @guessed,
                wrong_guesses: @wrong_guesses,
                num_of_wrong_guesses_left: @num_of_wrong_guesses_left,
                saved_file: @saved_file,
                file: @file
              })
  end

  def from_yaml
    data = YAML.load_file("./saves/#{@file}")
    @secret_word = data[:secret_word]
    @guessed = data[:guessed]
    @wrong_guesses = data[:wrong_guesses]
    @num_of_wrong_guesses_left = data[:num_of_wrong_guesses_left]
    @saved_file = data[:saved_file]
    @file = data[:file]
  end
end
