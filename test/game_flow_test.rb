require './test/test_helper'
require './lib/game_flow'
require './lib/ship_placement'
require 'pry'

class GameFlowTest < Minitest::Test
  def test_it_exists
    game = GameFlow.new
    assert_instance_of(GameFlow, game)
  end

  def test_other_classes
    game = GameFlow.new
    assert_instance_of(Text, game.text)
    assert_instance_of(Ship, game.comp_ship_2)
    assert_instance_of(Ship, game.comp_ship_3)
    assert_instance_of(Ship, game.player_ship_2)
    assert_instance_of(Ship, game.player_ship_3)
    assert_instance_of(Array, game.computer_board)
    assert_instance_of(Array, game.player_board)
  end

  def test_computer_can_not_place_ships_on_other_ships
    game = GameFlow.new
    game_logic = GameLogic.new(game)
    game_logic.place_computer_2_ship
    game_logic.place_computer_3_ship
    five_cells_with_ship = game.computer_board.map do |row|
      row.count(&:ship)
    end
    assert_equal 5, five_cells_with_ship.sum
  end

  def test_get_valid_cell_positions_array
    game = GameFlow.new
    actual = game.get_valid_cell_positions_array(game.player_board)
    assert_equal 'A1', actual[0]
    assert_equal 'D4', actual[15]
  end

  def test_time_calculator
    game = GameFlow.new
    game.quit_play_or_read('P')
    sleep(1)
    assert_equal 1, game.time_calculator
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

  def test_win_state
    game = GameFlow.new
    fire = FiringSequence.new(game)
    cell_1 = game.player_board[0][0]
    cell_2 = game.player_board[0][1]
    cell_3 = game.player_board[0][2]
    cell_4 = game.player_board[3][1]
    cell_5 = game.player_board[3][2]
    ship_1 = Ship.new(5)
    cell_1.ship = ship_1
    cell_2.ship = ship_1
    cell_3.ship = ship_1
    cell_4.ship = ship_1
    cell_5.ship = ship_1
    fire.fire_at_ships(cell_1)
    fire.fire_at_ships(cell_2)
    fire.fire_at_ships(cell_3)
    refute game.win_state(game.player_board, game.computer_board, fire.firing_counter)
  end
end
