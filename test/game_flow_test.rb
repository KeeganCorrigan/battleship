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
    skip
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

  def test_place_computer_3_ship
    new_game = GameFlow.new
    new_game.place_computer_3_ship
    any_cell_has_ship =
    new_game.computer_board.any? do |row|
      row.any? do |cell|
        cell.ship
      end
    end
    assert_equal true, any_cell_has_ship
  end
end
