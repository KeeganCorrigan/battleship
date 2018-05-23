require './test/test_helper'
require './lib/cell.rb'
require './lib/ship.rb'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new('A1')
    assert_instance_of(Cell, cell)
  end

  def test_it_has_position
    cell = Cell.new('A1')
    assert_equal 'A1', cell.position
  end

  def test_default_values
    cell = Cell.new('A1')
    refute cell.hit
    refute cell.miss
    assert_nil cell.ship
  end

  def test_it_starts_with_default_state
    cell = Cell.new('A1')
    assert_equal '~', cell.state
  end

  def test_it_can_change_state_to_hit
    cell = Cell.new('A1')
    ship = Ship.new(2)
    cell.ship = ship
    assert_equal 'H', cell.change_state
  end

  def test_it_can_change_state_to_miss
    cell = Cell.new('A1')
    assert_equal 'M', cell.change_state
  end

  def test_it_can_have_a_ship
    cell = Cell.new('A1')
    ship = Ship.new(2)
    cell.ship = ship
    assert_equal 2, cell.ship.length
  end
end
