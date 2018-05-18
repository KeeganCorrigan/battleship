require './test/test_helper'
require './lib/game_board'
require './lib/cell'
require 'pry'

class GameBoardTest < Minitest::Test
  def test_it_exists
    player_board = GameBoard.new
    assert_instance_of(GameBoard, player_board)
  end

  def test_it_can_create_a_cell
    player_board = GameBoard.new
    player_board.create_board
    assert_equal Cell, player_board.board_array[0][0].class
  end

  def test_it_can_create_a_row_of_four
    player_board = GameBoard.new
    player_board.create_board
    assert_equal 4, player_board.board_array[0].length
  end

  def test_it_has_four_rows
    player_board = GameBoard.new
    player_board.create_board
    assert_equal 4, player_board.board_array.length
  end
end
