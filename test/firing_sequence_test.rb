require './test/test_helper'
require './lib/game_flow'
require './lib/ship_placement'
require 'pry'

class FiringSequenceTest < Minitest::Test
  def test_it_exists
    game = GameFlow.new
    firing_sequence = FiringSequence(game)
    assert_instance_of(FiringSequence, firing_sequence)
  end
end
