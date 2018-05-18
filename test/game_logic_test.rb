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
end
