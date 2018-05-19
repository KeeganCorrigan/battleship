require './lib/cell'
require './lib/game_board'
require './lib/text'
require 'pry'

class GameLogic
  attr_reader :text, :first_coordinate

  def initialize
    @text = Text.new
  end

  def game_introduction
     p text.play_quit_or_instructions_text
     get_starting_input
  end

  def get_starting_input
    input = gets.chomp
    if input == 'p' || input == 'play'
      return
    elsif input == 'q'|| input == 'quit'
      quit_the_game
    elsif input == 'i' || input == 'instructions'
      p text.instruction_text
      game_introduction
    else
      p text.invalid_starting_choice_text
      game_introduction
    end
  end

  def quit_the_game
    exit
  end

  def first_coordinate
    coordinate = [rand(0..3), rand(0..3)]
    @first_coordinate = coordinate
  end

  def second_coordinate(first_coordinate.sample, ship_size)
    if coordinate == 0
      coordinate + (ship_size - 1)
    elsif coordinate == 3
      coordinate - (ship_size -1)
    else [(coordinate + (ship_size - 1)), (coordinate -   (ship_size - 1))].sample
    end
  end
end
