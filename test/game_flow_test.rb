require './test/test_helper'
require './lib/game_flow'
require './lib/ship_placement'
require 'pry'

class GameFlowTest < Minitest::Test
  def test_it_exists
    new_game = GameFlow.new
    assert_instance_of(GameFlow, new_game)
  end

  def test_other_classes
    new_game = GameFlow.new
    assert_instance_of(Text, new_game.text)
    assert_instance_of(Ship, new_game.comp_ship_2)
    assert_instance_of(Ship, new_game.comp_ship_3)
    assert_instance_of(Ship, new_game.player_ship_2)
    assert_instance_of(Ship, new_game.player_ship_3)
  end

  def test_computer_can_not_place_ships_on_other_ships
    game = GameFlow.new
    game.place_computer_2_ship
    game.place_computer_3_ship
    five_cells_with_ship = game.computer_board.map do |row|
      row.count do |cell|
        cell.ship
      end
    end
    assert_equal 5, five_cells_with_ship.sum
    game = GameFlow.new
    game.place_computer_2_ship
    game.place_computer_3_ship
    assert_equal 5, five_cells_with_ship.sum
    game = GameFlow.new
    game.place_computer_2_ship
    game.place_computer_3_ship
    assert_equal 5, five_cells_with_ship.sum
    game = GameFlow.new
    game.place_computer_2_ship
    game.place_computer_3_ship
    assert_equal 5, five_cells_with_ship.sum
    game = GameFlow.new
    game.place_computer_2_ship
    game.place_computer_3_ship
    assert_equal 5, five_cells_with_ship.sum
  end

  def test_get_valid_cell_positions_array
    game = GameFlow.new
    actual = game.get_valid_cell_positions_array(game.player_board)
    assert_equal "A1", actual[0]
    assert_equal "D4", actual[15]
  end

  def test_get_cell_state
    game = GameFlow.new
    input = "A1"
    actual = game.get_cell_state(input, game.computer_board)
    assert_equal "~", actual.state
  end

  def test_fire_at_ships_misses
    game = GameFlow.new
    input = "A1"
    game.fire_at_ships(input, game.computer_board)
    assert_equal "M", game.computer_board[0][0].state
  end

  def test_fire_at_ships_hits
    skip
    game = GameFlow.new
    input = "C2"
    player_ship = Ship.new(2)
    player_cells = [[2,2], [2,1]]
    game.place_player_2_ship(player_cells, player_ship)
    game.fire_at_ships(input, game.player_board)
    assert_equal "H", game.player_board[2][1].state
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

  def test_computer_fire_at_ships
    skip
    #how am I gonna test this thing?
    game = GameFlow.new
    expected = game.get_valid_cell_positions_array(game.player_board)
    assert_equal "A1", game.computer_fire_at_ships(game.player_board)
  end
end
