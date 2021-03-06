require './lib/ship'
require 'colorize'

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
    '~'.blue
  end

  def change_state
    if @ship
      hit_state
    else
      miss_state
    end
  end

  def hit_state
    @state = 'H'.red
  end

  def miss_state
    @state = 'M'
  end
end
