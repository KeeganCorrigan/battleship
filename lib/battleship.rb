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
firing_sequence = FiringSequence.new(game)
  until game.win_state == true
    firing_sequence.player_fires_shots
    firing_sequence.computer_fires_shots
  end
end

puts "Somebody won!"
