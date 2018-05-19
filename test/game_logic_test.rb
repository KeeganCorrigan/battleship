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

  def test_computer_can_choose_first_coordinate_for_2_piece_ship
    skip
    game = GameLogic.new
    assert_equal Array, game.first_coordinate.class
    assert_equal 2, game.first_coordinate.length
  end

  def test_second_coordinate
    game = GameLogic.new
    assert_equal 1, game.second_coordinate(0, 2)
    assert_equal 2, game.second_coordinate(3, 2)
    # need to test random second coordinate selection. It seems to work, but need an effective way to test 1 of 2 possibilities.
  end
end
