# 4 arrays of 4 will compose the playing board. Each index will be occupied by this cell object.

class Cell
  attr_reader :position

  attr_accessor :hit, :miss, :ship

  def initialize(position)
    @position = position
    @hit = false
    @miss = false
    @ship = false
  end
end
