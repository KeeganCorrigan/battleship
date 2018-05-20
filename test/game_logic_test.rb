require './test/test_helper'
require './lib/game_logic'
require './lib/text'
require 'pry'

class GameLogicTest < Minitest::Test
  def test_it_exists
    game = GameLogic.new
    assert_instance_of(GameLogic, game)
  end

  def test_it_has_text_class
    game = GameLogic.new
    assert_equal Text, game.text.class
  end

  def test_computer_can_choose_first_coordinate_picker_for_2_piece_ship
    game = GameLogic.new
    assert_equal Array, game.first_coordinate_picker.class
    assert_equal 2, game.first_coordinate_picker.length
  end

  def test_second_coordinate
    skip
    game = GameLogic.new
    assert_equal 1, game.second_coordinate(2, 0)
    assert_equal 2, game.second_coordinate(2, 3)
    # need to test random second coordinate selection. It seems to work, but need an effective way to test 1 of 2 possibilities.
  end

  def test_horizontal_ship_2
    game = GameLogic.new
    assert_equal [2,1], game.horizontal_ship(2, [2,0])
    assert_equal [2,2], game.horizontal_ship(2, [2,3])
  end

  def test_vertical_ship_2
    game = GameLogic.new
    assert_equal [1,2], game.vertical_ship(2, [0,2])
    assert_equal [2,2], game.vertical_ship(2, [3,2])
  end

  def test_generates_first_and_second_coordinates_for_2_ship
    game = GameLogic.new
    ship_2 = Ship.new(2)
    game.create_2_ship_coordinates(ship_2)
    assert_equal Array, game.first_coordinates.class
    assert_equal Array, game.second_coordinates.class
    assert_equal 2, game.first_coordinates.length
    assert_equal true, game.first_coordinates && [0, 1, 2, 3].any?
    assert_equal true, game.second_coordinates && [0, 1, 2, 3].any?
  end

  def test_horizontal_3_ship
    game = GameLogic.new
    assert_equal [0, 2], game.horizontal_ship(3, [0, 0])
    assert_equal [0, 3], game.horizontal_ship(3, [0, 1])
    assert_equal [0, 0], game.horizontal_ship(3, [0, 2])
    assert_equal [0, 1], game.horizontal_ship(3, [0, 3])
    assert_equal [1, 2], game.horizontal_ship(3, [1, 0])
    assert_equal [1, 3], game.horizontal_ship(3, [1, 1])
    assert_equal [1, 0], game.horizontal_ship(3, [1, 2])
    assert_equal [1, 1], game.horizontal_ship(3, [1, 3])
    assert_equal [2, 2], game.horizontal_ship(3, [2, 0])
    assert_equal [2, 3], game.horizontal_ship(3, [2, 1])
    assert_equal [2, 0], game.horizontal_ship(3, [2, 2])
    assert_equal [2, 1], game.horizontal_ship(3, [2, 3])
    assert_equal [3, 2], game.horizontal_ship(3, [3, 0])
    assert_equal [3, 3], game.horizontal_ship(3, [3, 1])
    assert_equal [3, 0], game.horizontal_ship(3, [3, 2])
    assert_equal [3, 1], game.horizontal_ship(3, [3, 3])
  end

  def test_vertical_ship_3
    game = GameLogic.new
    assert_equal [2, 0], game.vertical_ship(3, [0, 0])
    assert_equal [2, 1], game.vertical_ship(3, [0, 1])
    assert_equal [2, 2], game.vertical_ship(3, [0, 2])
    assert_equal [2, 3], game.vertical_ship(3, [0, 3])
    assert_equal [3, 0], game.vertical_ship(3, [1, 0])
    assert_equal [3, 1], game.vertical_ship(3, [1, 1])
    assert_equal [3, 2], game.vertical_ship(3, [1, 2])
    assert_equal [3, 3], game.vertical_ship(3, [1, 3])
    assert_equal [0, 1], game.vertical_ship(3, [2, 1])
    assert_equal [0, 2], game.vertical_ship(3, [2, 2])
    assert_equal [0, 3], game.vertical_ship(3, [2, 3])
    assert_equal [1, 0], game.vertical_ship(3, [3, 0])
    assert_equal [1, 1], game.vertical_ship(3, [3, 1])
    assert_equal [1, 2], game.vertical_ship(3, [3, 2])
    assert_equal [1, 3], game.vertical_ship(3, [3, 3])
  end

  def test_generates_first_and_second_coordinates_for_3_ship
    game = GameLogic.new
    ship_3 = Ship.new(3)
    game.create_2_ship_coordinates(ship_3)
    assert_equal Array, game.first_coordinates.class
    assert_equal Array, game.second_coordinates.class
    assert_equal 2, game.first_coordinates.length
    assert_equal true, game.first_coordinates && [0, 1, 2, 3].any?
    assert_equal true, game.second_coordinates && [0, 1, 2, 3].any?
  end

  def test_generate_ship_3_middle_coordinate
    game = GameLogic.new
    ship_3 = Ship.new(3)
    assert_equal [1, 1], game.generate_ship_3_middle_coordinate([1, 0], [1, 2], ship_3)
    assert_equal [2, 2], game.generate_ship_3_middle_coordinate([2, 1], [2, 3], ship_3)
    assert_equal [2, 1], game.generate_ship_3_middle_coordinate([2, 0], [2, 2], ship_3)
    assert_equal [0, 2], game.generate_ship_3_middle_coordinate([0, 1], [0, 3], ship_3)
    assert_equal [3, 2], game.generate_ship_3_middle_coordinate([3, 3], [3, 1], ship_3)
  end
end
