require './test/test_helper'
require './lib/game_flow'
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

  def test_place_computer_2_ship
    new_game = GameFlow.new
    new_game.place_computer_2_ship
    any_cell_has_ship =
    new_game.computer_board.any? do |row|
      row.any? do |cell|
        cell.ship
      end
    end
    assert_equal true, any_cell_has_ship
  end

  def test_place_computer_2_ship_places_2_ship_objects
    new_game = GameFlow.new
    new_game.place_computer_2_ship
    two_cells_have_ships =
    new_game.computer_board.map do |row|
      row.count do |cell|
        cell.ship
      end
    end
    assert_equal 2, two_cells_have_ships.sum
  end

  def test_place_computer_3_ship_places_3_ship_objects
    new_game = GameFlow.new
    new_game.place_computer_3_ship
    three_cells_have_ships =
    new_game.computer_board.map do |row|
      row.count do |cell|
        cell.ship
      end
    end
    assert_equal 3, three_cells_have_ships.sum
  end

  def test_can_not_place_ships_on_other_ships
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

  def test_get_player_ship_placement_choice
    game = GameFlow.new
    input = "A1 A3"
    assert_equal 2, game.get_player_ship_placement_choice(input).length
    assert_equal Array, game.get_player_ship_placement_choice(input).class
  end

  def test_change_player_ship_placement_to_positions
    game = GameFlow.new
    input = ["A1", "A3"]
    assert_equal [[0,0], [0,2]], game.change_player_ship_placement_to_positions(input)
    input = ["D4", "D1"]
    assert_equal [[3, 0], [3, 3]], game.change_player_ship_placement_to_positions(input)
  end

  def test_verify_player_ship_horizontal_vertical_placement
    game = GameFlow.new
    player_cells = [[0,0], [0,2]]
    assert_equal true, game.verify_player_horizontal_vertical_placement(player_cells)
    player_cells = [[1,0], [0,2]]
    assert_equal false, game.verify_player_horizontal_vertical_placement(player_cells)
  end

  def test_validate_player_ship_length
    game = GameFlow.new
    player_ship = Ship.new(2)
    player_cells = [[0,0], [0,2]]
    assert_equal false, game.validate_player_ship_length(player_cells, player_ship)
    player_ship = Ship.new(3)
    player_cells = [[0,0], [0,2]]
    assert_equal true,
    game.validate_player_ship_length(player_cells, player_ship)
    player_ship = Ship.new(3)
    player_cells = [[3,3], [3,1]]
    assert_equal true,
    game.validate_player_ship_length(player_cells, player_ship)
    player_ship = Ship.new(2)
    player_cells = [[2,2], [2,1]]
    assert_equal true, game.validate_player_ship_length(player_cells, player_ship)
    player_cells = [[2,3], [2,0]]
    assert_equal false, game.validate_player_ship_length(player_cells, player_ship)
  end

  def test_place_player_2_ship
    game = GameFlow.new
    player_ship = Ship.new(2)
    player_cells = [[2,2], [2,1]]
    game.place_player_2_ship(player_cells, player_ship)
    two_cells_have_ships =
    game.player_board.map do |row|
      row.count do |cell|
        cell.ship
      end
    binding.pry
    end
    assert_equal 2, two_cells_have_ships.sum
  end

  def test_get_cell_from_player_choice
    game = GameFlow.new
    player_cells = [[2,2], [2,1]]

  end

end
