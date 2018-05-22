require './lib/game_flow'
require './lib/ship_placement'
require './lib/firing_sequence'

game = GameFlow.new

game.game_start
computer_ship_placement = GameLogic.new(game)
computer_ship_placement.place_computer_ships
player_ship_placement = ShipPlacement.new(game)
player_ship_placement.place_ships
win_state_checker = false
until win_state_checker == true
firing_sequence = FiringSequence.new(game)
firing_sequence.fire_shots

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
  valid_choice = false
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
