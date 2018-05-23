require './test/test_helper'
require './lib/ship.rb'
require 'pry'

class ShipTest < Minitest::Test
  def test_it_exists
    ship_1 = Ship.new(2)
    assert_instance_of(Ship, ship_1)
  end

  def test_it_has_a_length
    ship_1 = Ship.new(2)
    assert_equal 2, ship_1.length
  end

  def test_it_has_a_name
    ship_1 = Ship.new(2, "Schooner")
    assert_equal "Schooner", ship_1.name
  end

  def test_it_has_a_size
    ship_1 = Ship.new(2, "Schooner", "2")
    assert_equal "2", ship_1.size
  end

  def test_length_can_decrease
    ship_1 = Ship.new(2)
    assert_equal 1, ship_1.take_hit
  end

  def test_ship_can_sink
    ship_1 = Ship.new(2)
    ship_1.take_hit
    ship_1.take_hit
    assert_equal true, ship_1.sunk
  end

  def test_sink_counter_increments
    ship_1 = Ship.new(2)
    ship_1.take_hit
    ship_1.take_hit
    ship_1.sunk
    assert_equal 1, ship_1.sink_counter
  end

  def test_sunk_returns_false_after_sink_counter_is_1
    ship_1 = Ship.new(2)
    ship_1.take_hit
    ship_1.take_hit
    ship_1.sunk
    assert_equal false, ship_1.sunk
  end
end
