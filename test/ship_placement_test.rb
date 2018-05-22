require './test/test_helper'
require './lib/ship_placement'
require './lib/game_flow'
require './lib/ship'
require './lib/text'
require './lib/cell'
require 'pry'

class ShipPlacementTest < Minitest::Test
  def test_it_exists
    ship_placement = ShipPlacement.new
    assert_instance_of(ShipPlacement, ship_placement)
  end

  def test_get_player_ship_placement_choice
    game = GameFlow.new
    ship_placement = ShipPlacement.new(game)
    input = "A1 A3"
    assert_equal 2, ship_placement.get_player_ship_placement_choice(input).length
    assert_equal Array, ship_placement.get_player_ship_placement_choice(input).class
  end

  def test_change_player_ship_placement_to_positions
    game = GameFlow.new
    ship_placement = ShipPlacement.new(game)
    input = ["A1", "A3"]
    assert_equal [[0,0], [0,2]], ship_placement.change_player_ship_placement_to_positions(input)
    input = ["D4", "D1"]
    assert_equal [[3, 0], [3, 3]], ship_placement.change_player_ship_placement_to_positions(input)
  end

  def test_verify_player_ship_horizontal_vertical_placement
    game = GameFlow.new
    ship_placement = ShipPlacement.new(game)
    player_cells = [[0,0], [0,2]]
    assert_equal true, ship_placement.verify_player_horizontal_vertical_placement(player_cells)
    player_cells = [[1,0], [0,2]]
    assert_equal false, ship_placement.verify_player_horizontal_vertical_placement(player_cells)
  end

  def test_validate_player_ship_length
    game = GameFlow.new
    ship_placement = ShipPlacement.new(game)
    player_ship = Ship.new(2)
    player_cells = [[0,0], [0,2]]
    assert_equal false, ship_placement.validate_player_ship_length(player_cells, player_ship)
    player_ship = Ship.new(3)
    player_cells = [[0,0], [0,2]]
    assert_equal true,
    ship_placement.validate_player_ship_length(player_cells, player_ship)
    player_ship = Ship.new(3)
    player_cells = [[3,3], [3,1]]
    assert_equal true,
    ship_placement.validate_player_ship_length(player_cells, player_ship)
    player_ship = Ship.new(2)
    player_cells = [[2,2], [2,1]]
    assert_equal true, ship_placement.validate_player_ship_length(player_cells, player_ship)
    player_cells = [[2,3], [2,0]]
    assert_equal false, ship_placement.validate_player_ship_length(player_cells, player_ship)
  end

  def test_get_cell_from_player_choice
    game = GameFlow.new
    ship_placement = ShipPlacement.new(game)
    player_cells = [[2,2], [2,1]]
    assert_equal "C3", ship_placement.get_cell_position(player_cells[0]).position
  end

  def test_place_player_2_ship
    game = GameFlow.new
    ship_placement = ShipPlacement.new(game)
    player_cells = [[2,2], [2,1]]
    ship_placement.place_player_2_ship(player_cells)
    two_cells_have_ships =
    game.player_board.map do |row|
      row.count do |cell|
        cell.ship
      end
    end
    assert_equal 2, two_cells_have_ships.sum
  end

  def test_place_player_3_ship
    game = GameFlow.new
    ship_placement = ShipPlacement.new(game)
    ship_placement.cell_1 = game.player_board[0][0]
    ship_placement.cell_2 = game.player_board[0][1]
    ship_placement.cell_3 = game.player_board[0][2]
    ship_placement.place_player_3_ship
    three_cells_have_ships = game.player_board.map do |row|
      row.count do |cell|
        cell.ship
      end
    end
    assert_equal 3, three_cells_have_ships.sum
  end
end
