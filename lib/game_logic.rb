require './lib/cell'
require './lib/game_board'
require './lib/ship'
require './lib/game_flow'

class GameLogic
  attr_reader :first_coordinates, :second_coordinates, :third_coordinates

  def initialize(game = nil)
    @game = game
  end

  def place_computer_ships
    place_computer_2_ship
    place_computer_3_ship
  end

  def place_computer_2_ship
    create_ship_coordinates(@game.comp_ship_2)
    @game.computer_board[first_coordinates[0]][first_coordinates[1]].ship = @game.comp_ship_2
    @game.computer_board[second_coordinates[0]][second_coordinates[1]].ship = @game.comp_ship_2
  end

  def place_computer_3_ship
    no_overlapping_ships = false
    until no_overlapping_ships == true
      create_ship_coordinates(@game.comp_ship_3)
      first_ship_cell =    @game.computer_board[first_coordinates[0]][first_coordinates[1]]
      second_ship_cell = @game.computer_board[second_coordinates[0]][second_coordinates[1]]
      third_ship_cell = @game.computer_board[third_coordinates[0]][third_coordinates[1]]
      no_overlapping_ships = @game.verify_no_ship_in_cell(first_ship_cell, second_ship_cell, third_ship_cell)
    end
    first_ship_cell.ship = @game.comp_ship_3
    second_ship_cell.ship = @game.comp_ship_3
    third_ship_cell.ship = @game.comp_ship_3
  end

  def first_coordinate_picker
    first_coordinates = [rand(0..3), rand(0..3)]
  end

  def horizontal_ship(ship_size, first_coordinate)
    horizontal = second_coordinate_picker(ship_size, first_coordinate[1])
    second_coordinates = first_coordinate.clone
    second_coordinates.delete_at(1)
    second_coordinates.push(horizontal)
  end

  def vertical_ship(ship_size, first_coordinate)
    vertical = second_coordinate_picker(ship_size, first_coordinate[0])
    second_coordinates = first_coordinate.clone
    second_coordinates.delete_at(0)
    second_coordinates.unshift(vertical)
  end

  def second_coordinate_picker(ship_size, coordinate)
    if coordinate == 0
      coordinate + (ship_size - 1)
    elsif coordinate == 3
      coordinate - (ship_size -1)
    elsif ship_size == 3 && coordinate == 2
      coordinate - (ship_size - 1)
    elsif ship_size == 3 && coordinate == 1
      coordinate + (ship_size - 1)
    else [(coordinate + (ship_size - 1)), (coordinate - (ship_size - 1))].sample
    end
  end

  def create_ship_coordinates(ship)
    @first_coordinates = first_coordinate_picker
    @second_coordinates = [horizontal_ship(ship.length, first_coordinates), vertical_ship(ship.length, first_coordinates)].sample
    if ship.length == 3
      @third_coordinates = generate_ship_3_middle_coordinate(first_coordinates, second_coordinates)
    end
  end

  def generate_ship_3_middle_coordinate(first_coordinates, second_coordinates)
    third_coordinates = first_coordinates.map.with_index do |position, index|
      if position - second_coordinates[index] == 0
        position
      else
        sorted = [position, second_coordinates[index]].sort
        sorted = (sorted[0]..sorted[1]).to_a
        sorted.delete(position)
        sorted.delete(second_coordinates[index])
        sorted
      end
    end
    return third_coordinates.flatten
  end
end
