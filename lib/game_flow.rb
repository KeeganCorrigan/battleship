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

def quit_play_or_read
    input = get_player_input
    if input == 'p' || input == 'play'
      return
    elsif input == 'q'|| input == 'quit'
      quit_the_game
    elsif input == 'i' || input == 'instructions'
      p text.instruction_text
      quit_play_or_read
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
    text.play_quit_or_instructions_text
  end

  def get_player_input
    gets.chomp
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
    return true
  end

  def get_player_2_ship_placement_choice(input)
    if input.split(" ").length != 2
      p text.invalid_input
      input = get_player_input
      get_player_2_ship_placement_choice(input)
    else
      return input.upcase.split(" ")
    end
  end

  def change_player_ship_placement_to_positions(player_cell_choice)
    player_cell_array = []
    @player_board.each_with_index do |row, index_1|
      row.each_with_index do |cell, index_2|
        player_cell_choice.each do |choice|
          player_cell_array << [index_1, index_2] if cell.position == choice
        end
      end
    end
    return player_cell_array
  end

  def verify_player_horizontal_vertical_placement(player_cells)
    if player_cells[0][0] == player_cells[1][0] || player_cells[0][1] == player_cells[1][1]
      return true
    else
      return false
    end
  end

  def validate_player_ship_length(player_cells, ship)
    if (player_cells[0][0] - player_cells[1][0]).abs == (ship.length - 1) || (player_cells[0][1] - player_cells[1][1]).abs == (ship.length - 1)
      return true
    else
      return false
    end
  end

  def place_player_2_ship(player_cells, ship)
    @player_board[player_cells[0][0]][player_cells[1][0]].ship = ship
    @player_board[player_cells[0][1]][player_cells[1][1]].ship = ship
  end

  # def place_player_3_ship(player_cells, ship)
  #   no_overlapping_ships = false
  #   until no_overlapping_ships == true
  #     first_ship_cell = @player_board[player_cells[0][0]][player_cells[1][0]]
  #     second_ship_cell = @player_board[player_cells[0][1]][player_cells[1][1]]
  #     third_ship_cell = @player_board[@game_logic.generate_ship_3_middle_coordinate(player_cells[0], player_cells[1])
  #     no_overlapping_ships = verify_no_ship_in_cell(first_ship_cell, second_ship_cell, third_ship_cell)
  #   end
  #   first_ship_cell.ship = player_ship_3
  #   second_ship_cell.ship = player_ship_3
  #   third_ship_cell.ship = player_ship_3
  # end

end
