require './lib/cell'

class GameBoard
  attr_reader :cell, :board_array

  def initialize(cell = nil)
    @cell = cell
    @board_array = []
  end

  def create_board
    cells = []
    cells.push("A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4")
    @board_array = cells.map do |position|
      Cell.new(position)
    end
    @board_array = @board_array.each_slice(4).to_a
  end

  def display_board
    puts "          ===========\n
          . 1 2 3 4  \n
          A #{@board_array[0][0].state} #{@board_array[0][1].state} #{@board_array[0][2].state} #{@board_array[0][3].state}         \n
          B #{@board_array[1][0].state} #{@board_array[1][1].state} #{@board_array[1][2].state} #{@board_array[1][3].state}         \n
          C #{@board_array[2][0].state} #{@board_array[2][1].state} #{@board_array[2][2].state} #{@board_array[2][3].state}           \n
          D #{@board_array[3][0].state} #{@board_array[3][1].state} #{@board_array[3][2].state} #{@board_array[3][3].state}         \n
          ===========\n"
  end
end

board = GameBoard.new

board.create_board
board.display_board
