require './lib/cell'
require './lib/game_board'
require './lib/text'

class GameLogic
  attr_reader :text

  def initialize
    @text = Text.new
  end

  def game_introduction
    text.play_quit_or_instructions_text
    get_starting_input
  end

  def get_starting_input
    input = gets.chomp
    if input == 'p' || input == 'play'
      return
    elsif input == 'q'|| input == 'quit'
      quit_the_game
    elsif input == 'i' || input == 'instructions'
      text.instruction_text
      game_introduction
    else
      text.invalid_starting_choice_text
      game_introduction
    end
  end

  def quit_the_game
    exit
  end
end
