# this is just a runner file that starts the program
require './lib/game_flow'

game = GameFlow.new

#game start and comuter placement

p game.start
game.quit_play_or_read
game.place_computer_2_ship
game.place_computer_3_ship
valid_input = false
p game.text.begin_play_text

# player 2 ship placement

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

# player 3 ship placement validity check

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

# player ship 3 placement initial verification and middle coordinate generation

  if valid_range && valid_size == true
    middle = game.game_logic.generate_ship_3_middle_coordinate(player_cells[0], player_cells[1])
    cell_1 = game.get_cell_position(player_cells[0])
    cell_2 = game.get_cell_position(player_cells[1])
    cell_3 = game.get_cell_position(middle)
    no_overlapping_ships = game.verify_no_ship_in_cell(cell_1, cell_2, cell_3)

#check if overlapping ship

    if no_overlapping_ships == false
      p game.text.ships_can_not_overlap
    end
  end

#final check

  if valid_range && valid_size && no_overlapping_ships == true
    valid_input = true
  end
end

# place player 3 ship

game.place_player_3_ship(cell_1, cell_2, cell_3, game.player_ship_3)

# Player verify firing location

win_state_checker = false

until win_state_checker == true
  valid_choice = false
  until valid_choice == true
    p game.text.player_firing_turn
    input = game.get_player_input
    valid_inputs = game.get_valid_cell_positions_array(game.computer_board)
    if valid_inputs.include?(input) != true
      p game.text.player_invalid_fire_Square_selection_text
    end
    cell = game.get_cell_state(input, game.computer_board)
    if cell.state != "~"
      p game.text.player_already_fired_on_same_sqaure_text
    end
    if cell.state == "~"
      valid_choice = true
    end
  end

# player fires

  game.fire_at_ships(input, game.computer_board)
    if cell.state == "H"
      p game.text.confirm_player_hit_text
      cell.ship.take_hit
    elsif cell.state == "M"
      p game.text.confirm_player_miss_text
    end
  game.display_board(game.computer_board)
  valid_choice = false

# Verify ship sink

  if game.comp_ship_2.sunk == true
    p game.text.confirm_computer_ship_was_sunk(game.comp_ship_2.name, game.comp_ship_2.size)
  end
  if game.comp_ship_3.sunk == true
    p game.text.confirm_computer_ship_was_sunk(game.comp_ship_3.name, game.comp_ship_3.size)
  end
  if game.win_state(game.comp_ship_2, game.comp_ship_3) == true
    win_state_checker = true
  end

#computer_choice_fire_loop

  until valid_choice == true
    input = game.computer_fire_at_ships(game.player_board)
    cell = game.get_cell_state(input, game.player_board)
    valid_inputs = game.get_valid_cell_positions_array(game.computer_board)
    if cell.state == "~"
      valid_choice = true
    end
  end

# computer_fires

  p game.text.confirm_computer_firing_location(cell.position)
  game.fire_at_ships(input, game.player_board)
  if cell.state == "H"
    p game.text.confirm_computer_hit_text
    cell.ship.take_hit
  elsif cell.state == "M"
    p game.text.confirm_computer_miss_text
  end
  if game.win_state(game.player_ship_2, game.player_ship_3) == true
    win_state_checker = true
  end
  game.display_board(game.player_board)
end
p "Somebody won!"
