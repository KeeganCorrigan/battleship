# 4 arrays of 4 will compose the playing board. Each index will be occupied by this cell object.

class Cell
  attr_reader :position

  attr_accessor :hit, :miss, :ship, :state

  def initialize(position, state = default_state)
    @position = position
    @state = state
    @hit = false
    @miss = false
    @ship = false
  end

  def default_state
    '~'
  end

  def hit_state
    # if player_input is true && ship is true
    'H'
    #can not change state once hit_state is chosen
  end

  def miss_state
    # if player_input is true && ship is not true
    'M'
    #can not change state once miss_state is chosen
  end
end
