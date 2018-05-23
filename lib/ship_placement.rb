require './lib/game_flow'

class ShipPlacement
  attr_accessor :cell_1, :cell_2, :cell_3

  def initialize(game = nil)
    @game = game
  end

  def place_ships
    player_cells = validate_player_2_ship
    place_player_2_ship(player_cells)
    valid_input = false
    until valid_input == true
      puts @game.text.player_places_three_unit_ship_text
      input = @game.get_player_input
      player_cell_choice = get_player_ship_placement_choice(input)
      player_cells = change_player_ship_placement_to_positions(player_cell_choice)
      valid_input = validate_player_ship_3_position(player_cells)
    end
    place_player_3_ship
    @game.small_pause
    @game.clear_screen
  end

  def get_player_ship_placement_choice(input)
    if validate_player_ship_placement_choices(input) == true
      return input.upcase.split(" ")
    else
      p @game.text.invalid_input
      input = @game.get_player_input
      get_player_ship_placement_choice(input)
    end
  end

  def validate_player_ship_placement_choices(input)
    input_array = input.split(' ')
    valid_choices = @game.get_valid_cell_positions_array(@game.player_board)
    if valid_choices.include?(input_array[0]) && valid_choices.include?(input_array[1]) && input_array.length == 2
      return true
    else
      return false
    end
  end

  def change_player_ship_placement_to_positions(player_cell_choice)
    player_cell_array = []
    @game.player_board.each_with_index do |row, index_1|
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

  def get_cell_position(player_cell)
    @game.player_board[player_cell[0]][player_cell[1]]
  end

  def place_player_2_ship(player_cells)
    @game.player_board[player_cells[0][0]][player_cells[0][1]].ship = @game.player_ship_2
    @game.player_board[player_cells[1][0]][player_cells[1][1]].ship = @game.player_ship_2
  end

  def place_player_3_ship
    @cell_1.ship = @game.player_ship_3
    @cell_2.ship = @game.player_ship_3
    @cell_3.ship = @game.player_ship_3
  end

  def assign_player_cells(player_cells, middle)
    @cell_1 = get_cell_position(player_cells[0])
    @cell_2 = get_cell_position(player_cells[1])
    @cell_3 = get_cell_position(middle)
  end

  def get_player_ship_position
    puts @game.text.player_places_two_unit_ship_text
    @game.get_player_input
  end

  def validate_player_ship_2_position(player_cells)
    valid_input = false
    valid_range = verify_player_horizontal_vertical_placement(player_cells)
    valid_size = validate_player_ship_length(player_cells, @game.player_ship_2)
    if valid_range == false
      puts @game.text.ship_diagonal_placement_text
    end
    if valid_size == false
      puts @game.text.ship_length_incorrect_or_wrap_attempt
    end
    if valid_range && valid_size == true
      valid_input = true
    end
    return valid_input
  end

  def validate_player_2_ship
    valid_input = false
    until valid_input == true
      input = get_player_ship_position
      player_cell_choice = get_player_ship_placement_choice(input)
      player_cells = change_player_ship_placement_to_positions(player_cell_choice)
      valid_input = validate_player_ship_2_position(player_cells)
    end
    return player_cells
  end

  def validate_player_ship_3_position(player_cells)
    valid_input = false
    valid_range = verify_player_horizontal_vertical_placement(player_cells)
    valid_size = validate_player_ship_length(player_cells, @game.player_ship_3)
    handle_diagonal_ship(valid_range)
    handle_wrapping_ship(valid_size)
    if valid_range && valid_size == true
      middle = @game.game_logic.generate_ship_3_middle_coordinate(player_cells[0], player_cells[1])
      assign_player_cells(player_cells, middle)
      no_overlapping_ships = handle_overlapping_ships
      if valid_range && valid_size && no_overlapping_ships == true
        valid_input = true
      end
    end
    return valid_input
  end

  def handle_diagonal_ship(valid_range)
    if valid_range == false
      puts @game.text.ship_diagonal_placement_text
    end
  end

  def handle_wrapping_ship(valid_size)
    if valid_size == false
      puts @game.text.ship_length_incorrect_or_wrap_attempt
    end
  end

  def handle_overlapping_ships
    no_overlapping_ships = @game.verify_no_ship_in_cell(@cell_1, @cell_2, @cell_3)
    if no_overlapping_ships == false
      p @game.text.ships_can_not_overlap
    end
    return no_overlapping_ships
  end
end
