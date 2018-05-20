# this is just a runner file that starts the program
require './lib/game_flow'

game = GameFlow.new

game.start
game.place_computer_2_ship
game.place_computer_3_ship
game.text.begin_play_text
