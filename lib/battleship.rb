# this is just a runner file that starts the program
require './lib/game_logic'
require './lib/game_board'

game = GameLogic.new
player_board = GameBoard.new

game.game_introduction
player_board.create_board
player_board.display
