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
    skip
    game = GameFlow.new
    game.game_logic(game).place_computer_2_ship
    game.game_logic(game).place_computer_2_ship
    five_cells_with_ship = game.computer_board.map do |row|
      row.count do |cell|
        cell.ship
      end
    end
    assert_equal 5, five_cells_with_ship.sum
  end

  def test_get_valid_cell_positions_array
    game = GameFlow.new
    actual = game.get_valid_cell_positions_array(game.player_board)
    assert_equal "A1", actual[0]
    assert_equal "D4", actual[15]
  end

  def test_time_calculator
    game = GameFlow.new
    game.quit_play_or_read("P")
    sleep(1)
    assert_equal 1, game.time_calculator
  end

  def test_count_hits_on_ships
    skip
    game = GameFlow.new
    input = "C2"
    player_ship = Ship.new(2)
    player_cells = [[2,2], [2,1]]
    game.place_player_2_ship(player_cells, player_ship)
    game.fire_at_ships(input, game.player_board)
    assert_equal 1, game.count_hits_on_ships(game.player_board)
    input = "C3"
    game.fire_at_ships(input, game.player_board)
    assert_equal 2, game.count_hits_on_ships(game.player_board)
  end

  def test_win_state
    skip
    game = GameFlow.new
    player_ship = Ship.new(2)
    player_cells = [[2,2], [2,1]]
    game.place_player_2_ship(player_cells, player_ship)
    player_cells = [[3,2], [3,0]]
    middle = [3,1]
    player_ship = Ship.new(3)
    cell_1 = game.get_cell_position(player_cells[0])
    cell_2 = game.get_cell_position(player_cells[1])
    cell_3 = game.get_cell_position(middle)
    game.place_player_3_ship(cell_1, cell_2, cell_3, player_ship)
    input = "D3"
    game.fire_at_ships(input, game.player_board)
    assert_equal false, game.win_state(game.player_board)
    input = "D2"
    game.fire_at_ships(input, game.player_board)
    assert_equal false, game.win_state(game.player_board)
    input = "D1"
    game.fire_at_ships(input, game.player_board)
    assert_equal false, game.win_state(game.player_board)
    input = "C2"
    game.fire_at_ships(input, game.player_board)
    assert_equal false, game.win_state(game.player_board)
    input = "C3"
    game.fire_at_ships(input, game.player_board)
    assert_equal 5, game.count_hits_on_ships(game.player_board)
    assert game.win_state(game.player_board)
  end
end
