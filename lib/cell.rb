require './lib/ship'

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

  def change_state
    if @ship != nil
      hit_state
    else
      miss_state
    end
  end

  def hit_state
    @state = 'H'
  end

  def miss_state
    @state = 'M'
  end
end
