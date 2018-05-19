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
end
