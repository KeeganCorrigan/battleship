require './test/test_helper'
require './lib/game_flow'
require './lib/ship_placement'
require './lib/cell'
require 'pry'

class FiringSequenceTest < Minitest::Test
  def test_it_exists
    game = GameFlow.new
    fire = FiringSequence.new(game)
    assert_instance_of(FiringSequence, fire)
  end

  def test_game_exists
    game = GameFlow.new
    fire = FiringSequence.new(game)
    assert_equal GameFlow, fire.game.class
  end

  def test_shots_fired_is_0
    game = GameFlow.new
    fire = FiringSequence.new(game)
    assert_equal 0, fire.shots_fired
  end

  def test_shots_fired_increments
    game = GameFlow.new
    fire = FiringSequence.new(game)
    fire.firing_counter
    fire.firing_counter
    assert_equal 2, fire.shots_fired
  end

  def test_verify_player_ship_sunk
    game = GameFlow.new
    fire = FiringSequence.new(game)
    cell = Cell.new("A1")
    refute fire.verify_player_ship_sunk(cell)
    ship = Ship.new(1)
    ship.sunk == true
    cell.ship = ship
    assert_nil fire.verify_player_ship_sunk(cell)
  end

  def test_verify_computer_ship_sunk
    game = GameFlow.new
    fire = FiringSequence.new(game)
    cell = Cell.new("A1")
    refute fire.verify_computer_ship_sunk(cell)
    ship = Ship.new(1)
    ship.sunk == true
    cell.ship = ship
    assert_nil fire.verify_computer_ship_sunk(cell)
  end

  def test_computer_fire_at_ships
    game = GameFlow.new
    fire = FiringSequence.new(game)
    assert_equal String, fire.computer_fire_at_ships(game.player_board).class
    assert_equal 2, fire.computer_fire_at_ships(game.player_board).length
  end

  def test_fire_at_ships
    game = GameFlow.new
    fire = FiringSequence.new(game)
    cell = Cell.new("A1")
    fire.fire_at_ships(cell)
    assert_equal "M", cell.state
    ship = Ship.new(1)
    new_cell = Cell.new("A1")
    new_cell.ship = ship
    fire.fire_at_ships(new_cell)
    assert_equal "H", new_cell.state
  end

  def test_get_cell_state
    game = GameFlow.new
    fire = FiringSequence.new(game)
    input = "A1"
    actual = fire.get_cell_state(input, game.computer_board)
    assert_equal "~", actual.state
  end

  def test_validate_cell_state
    game = GameFlow.new
    fire = FiringSequence.new(game)
    cell = Cell.new("A1")
    assert fire.validate_cell_state(cell)
    fire.fire_at_ships(cell)
    refute fire.validate_cell_state(cell)
  end

  def test_validate_cell_input
    game = GameFlow.new
    fire = FiringSequence.new(game)
    input = "A1"
    assert fire.validate_cell_input(input)
    input = "D5"
    refute fire.validate_cell_input(input)
  end

  def test_cell_state_hit
    game = GameFlow.new
    fire = FiringSequence.new(game)
    cell = Cell.new("A1")
    ship = Ship.new(1)
    refute fire.cell_state_hit(cell, game.player_board)
    cell.ship = ship
    fire.fire_at_ships(cell)
    assert fire.cell_state_hit(cell, game.player_board)
  end

  def test_cell_state_miss
    game = GameFlow.new
    fire = FiringSequence.new(game)
    cell = Cell.new("A1")
    refute fire.cell_state_miss(cell, game.player_board)
    fire.fire_at_ships(cell)
    assert_nil fire.cell_state_miss(cell, game.player_board)
  end
end
