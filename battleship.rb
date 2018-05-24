require './lib/game_flow'
require './lib/ship_placement'
require './lib/firing_sequence'

game = GameFlow.new

game.game_start
computer_ship_placement = GameLogic.new(game)
computer_ship_placement.place_computer_ships
player_ship_placement = ShipPlacement.new(game)
player_ship_placement.place_ships
firing_sequence = FiringSequence.new(game)
until game.win_state(game.computer_board, game.player_board, firing_sequence.shots_fired) == true
  firing_sequence.player_fires_shots
  game.win_state(game.computer_board, game.player_board, firing_sequence.shots_fired)
  firing_sequence.computer_fires_shots
end
