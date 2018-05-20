# this is just a runner file that starts the program
require './lib/game_flow'

game = GameFlow.new

p game.start
game.quit_play_or_read
game.place_computer_2_ship
game.place_computer_3_ship
p game.text.begin_play_text
input = game.get_player_input
game.get_player_2_ship_placement_choice(input)
