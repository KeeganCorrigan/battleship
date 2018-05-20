require './lib/ship'
require './lib/game_board'
require './lib/text'
require './lib/game_logic'
require './lib/cell'

class GameFlow

  attr_reader :text, :comp_ship_2, :comp_ship_3, :computer_board, :player_ship_2, :player_ship_3, :player_board

  def initialize
    @text = Text.new
    @comp_ship_2 = Ship.new(2)
    @comp_ship_3 = Ship.new(3)
    @computer_board = GameBoard.new.create_board
    @player_ship_2 = Ship.new(2)
    @player_ship_3 = Ship.new(3)
    @player_board = GameBoard.new.create_board
    @game_logic = GameLogic.new
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

  def game_introduction
     p text.play_quit_or_instructions_text
     get_starting_input
  end

  def quit_the_game
    exit
  end

  def start
    p text.play_quit_or_instructions_text
    get_starting_input
  end

  def place_computer_2_ship
    @game_logic.create_ship_coordinates(comp_ship_2)

    @computer_board[@game_logic.first_coordinates[0]][@game_logic.first_coordinates[1]].ship = comp_ship_2

    @computer_board[@game_logic.second_coordinates[0]][@game_logic.second_coordinates[1]].ship = comp_ship_2

  end

  def place_computer_3_ship
    no_overlapping_ships = false
    until no_overlapping_ships == true
      @game_logic.create_ship_coordinates(comp_ship_3)
      first_ship_cell =    @computer_board[@game_logic.first_coordinates[0]][@game_logic.first_coordinates[1]]
      second_ship_cell = @computer_board[@game_logic.second_coordinates[0]][@game_logic.second_coordinates[1]]
      third_ship_cell = @computer_board[@game_logic.third_coordinates[0]][@game_logic.third_coordinates[1]]
      no_overlapping_ships = verify_no_ship_in_cell(first_ship_cell, second_ship_cell, third_ship_cell)
    end
    first_ship_cell.ship = comp_ship_3
    second_ship_cell.ship = comp_ship_3
    third_ship_cell.ship = comp_ship_3
  end

  def verify_no_ship_in_cell(cell1, cell2, cell3)
    if cell1.ship || cell2.ship || cell3.ship != nil
      return false
    end
    else
      return true
  end
end
#
# game = GameFlow.new
#
# game.start
