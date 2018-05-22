require './lib/game_flow'
require './lib/ship_placement'

game = GameFlow.new

game.game_start
computer_ship_placement = GameLogic.new(game)
computer_ship_placement.place_computer_ships
player_ship_placement = ShipPlacement.new(game)
player_ship_placement.place_ships
win_state_checker = false
until win_state_checker == true
firing_sequence = FiringSequence.new(game)
firing_sequence.player_fire


  valid_choice = false
  until valid_choice == true
    puts game.text.player_firing_turn
    input = game.get_player_input
    valid_inputs = game.get_valid_cell_positions_array(game.computer_board)
    if valid_inputs.include?(input) != true
      puts game.text.player_invalid_fire_Square_selection_text
    end
    cell = game.get_cell_state(input, game.computer_board)
    if cell.state != "~"
      puts game.text.player_already_fired_on_same_sqaure_text
    end
    if cell.state == "~"
      valid_choice = true
    end
  end

# player fires

  game.fire_at_ships(input, game.computer_board)
    if cell.state == "H"
      puts game.text.confirm_player_hit_text
      cell.ship.take_hit
    elsif cell.state == "M"
      puts game.text.confirm_player_miss_text
    end
  game.display_board(game.computer_board)
  valid_choice = false

# Verify ship sink

  if game.comp_ship_2.sunk == true
    puts game.text.confirm_computer_ship_was_sunk(game.comp_ship_2.name, game.comp_ship_2.size)
  end
  if game.comp_ship_3.sunk == true
    puts game.text.confirm_computer_ship_was_sunk(game.comp_ship_3.name, game.comp_ship_3.size)
  end
  if game.win_state(game.computer_board) == true
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

  puts game.text.confirm_computer_firing_location(cell.position)
  game.fire_at_ships(input, game.player_board)
  if cell.state == "H"
    puts game.text.confirm_computer_hit_text
    cell.ship.take_hit
  elsif cell.state == "M"
    puts game.text.confirm_computer_miss_text
  end
  if game.win_state(game.player_board) == true
    win_state_checker = true
  end
  game.display_board(game.player_board)
end

puts "Somebody won!"
