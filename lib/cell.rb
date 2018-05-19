# 4 arrays of 4 will compose the playing board. Each index will be occupied by this cell object.

class Cell
  attr_reader :position

  attr_accessor :hit, :miss, :ship, :state

  def initialize(position, state = default_state)
    @position = position
    @state = state
    @hit = false
    @miss = false
    @ship = nil
  end

  def default_state
    '~'
  end

  def hit_state
    if @ship == true
      'H'
    end
  end

  def miss_state
    if @ship == false
      'M'
    end
  end
end
