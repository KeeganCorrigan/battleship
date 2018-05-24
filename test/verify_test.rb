require './test/test_helper'
require './lib/game_flow'


class VerifyTest < Minitest::Test
  def test_verify_no_ship_in_cell
    game = GameFlow.new
    cell_1 = game.computer_board[0][0]
    cell_2 = game.computer_board[0][1]
    cell_3 = game.computer_board[0][2]
    assert game.verify_no_ship_in_cell(cell_1, cell_2, cell_3)
    cell_1.ship = Ship.new(2)
    refute game.verify_no_ship_in_cell(cell_1, cell_2, cell_3)
  end

  def test_get_valid_cell_positions_array
    game = GameFlow.new
    actual = game.get_valid_cell_positions_array(game.player_board)
    assert_equal 'A1', actual[0]
    assert_equal 'D4', actual[15]
  end

  def test_count_hits_on_ships
    game = GameFlow.new
    fire = FiringSequence.new(game)
    cell = game.player_board[0][0]
    ship = Ship.new(1)
    cell.ship = ship
    fire.fire_at_ships(cell)
    assert_equal 1, game.count_hits_on_ships(game.player_board)
  end
end
