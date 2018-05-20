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
  end
end
