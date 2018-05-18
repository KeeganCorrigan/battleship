require './test/test_helper'
require './lib/cell.rb'
require 'pry'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new("A1")
    assert_instance_of(Cell, cell)
  end

  def test_it_has_position
    cell = Cell.new("A1")
    assert_equal "A1", cell.position
  end

  def test_it_can_be_hit
    skip
    cell = Cell.new("A1")
    # something happens here to have it change to H
    assert_equal "H", cell.display
  end

  def test_it_can_be_missed
    skip
    cell = Cell.new("A1")
    # something happens here to change it to M
    assert_equal "M", cell.display
  end

  def test_it_can_have_a_ship
    skip
    cell = Cell.new("A1")
    # something happens here that means it has a ship!
    assert_equal true, cell.ship?
  end
end
