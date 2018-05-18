require './lib/cell'

class GameBoard
  attr_reader :cell, :board_array

  def initialize(cell = nil)
    @cell = cell
    @board_array = []
  end

  def create_board
    @board_array.push([Cell.new("A1"), Cell.new("A2"), Cell.new("A3"), Cell.new("A4")], [Cell.new("B1"), Cell.new("B2"), Cell.new("B3"), Cell.new("B4")], [Cell.new("C1"), Cell.new("C2"), Cell.new("C3"), Cell.new("C4")], [Cell.new("D1"), Cell.new("D2"), Cell.new("D3"), Cell.new("D4")])
  end
end
