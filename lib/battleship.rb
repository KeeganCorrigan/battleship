# this is just a runner file that starts the program
require './lib/game_flow'

game = GameFlow.new

p game.start
game.quit_play_or_read
game.place_computer_2_ship
game.place_computer_3_ship
valid_input = false
p game.text.begin_play_text

until valid_input == true
  p game.text.player_places_two_unit_ship_text
  input = game.get_player_input
  player_cell_choice = game.get_player_ship_placement_choice(input)
  player_cells = game.change_player_ship_placement_to_positions(player_cell_choice)
  valid_range = game.verify_player_horizontal_vertical_placement(player_cells)
  valid_size = game.validate_player_ship_length(player_cells, game.player_ship_2)

  if valid_range == false
    p game.text.ship_diagonal_placement_text
  end

  if valid_size == false
    p game.text.ship_length_incorrect_or_wrap_attempt
  end

  if valid_range && valid_size == true
    valid_input = true
  end
end

game.place_player_2_ship(player_cells, game.player_ship_2)
valid_input = false

until valid_input == true

  p game.text.player_places_three_unit_ship_text
  input = game.get_player_input
  player_cell_choice = game.get_player_ship_placement_choice(input)
  player_cells = game.change_player_ship_placement_to_positions(player_cell_choice)
  valid_range = game.verify_player_horizontal_vertical_placement(player_cells)
  valid_size = game.validate_player_ship_length(player_cells, game.player_ship_3)

  if valid_range == false
    p game.text.ship_diagonal_placement_text
  end

  if valid_size == false
    p game.text.ship_length_incorrect_or_wrap_attempt
  end

  if valid_range && valid_size == true
    middle = game.game_logic.generate_ship_3_middle_coordinate(player_cells[0], player_cells[1])
    cell_1 = game.get_cell_position(player_cells[0])
    cell_2 = game.get_cell_position(player_cells[1])
    cell_3 = game.get_cell_position(middle)
    no_overlapping_ships = game.verify_no_ship_in_cell(cell_1, cell_2, cell_3)

    if no_overlapping_ships == false
      p game.text.ships_can_not_overlap
    end
  end

  if valid_range && valid_size && no_overlapping_ships == true
    valid_input = true
  end
end

game.place_player_3_ship(cell_1, cell_2, cell_3, game.player_ship_3)
binding.pry
p game.text.player_firing_turn
game.computer_board.display
