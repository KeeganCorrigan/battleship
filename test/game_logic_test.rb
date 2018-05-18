require './test/test_helper'
require './lib/game_logic.rb'
require 'pry'

class GameLogicTest < Minitest::Test
  def test_it_exists
    game = GameLogic.new
    assert_instance_of(GameLogic, game)
  end
end
