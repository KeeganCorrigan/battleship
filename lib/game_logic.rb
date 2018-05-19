require './lib/cell'
require './lib/game_board'
require './lib/text'
require './lib/ship'
require './lib/game_flow'
require 'pry'

class GameLogic
  attr_reader :text, :first_coordinates, :second_coordinates

  def initialize
    @text = Text.new
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
    else [(coordinate + (ship_size - 1)), (coordinate -   (ship_size - 1))].sample
    end
  end

  def create_2_ship_coordinates(ship_2)
    @first_coordinates = first_coordinate_picker
    @second_coordinates = [horizontal_ship(ship_2.length, first_coordinates), vertical_ship(ship_2.length, first_coordinates)].sample
  end

  def create_3_ship_coordinates(ship_3)
    @first_coordinates = first_coordinate_picker
    @second_coordinates = [horizontal_ship(ship_3.length, first_coordinates), vertical_ship(ship_3.length, first_coordinates)].sample
  end
end
