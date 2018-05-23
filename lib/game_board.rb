require './lib/cell'
require 'pry'

class GameBoard
  attr_reader :board_array

  def initialize
    @board_array = []
  end

  def create_board
    cells = []
    cells.push('A1', 'A2', 'A3', 'A4', 'B1', 'B2', 'B3', 'B4', 'C1', 'C2', 'C3', 'C4', 'D1', 'D2', 'D3', 'D4')
    @board_array = cells.map do |position|
      Cell.new(position)
    end
    @board_array = @board_array.each_slice(4).to_a
  end
end
