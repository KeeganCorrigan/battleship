require 'pry'
require './lib/cell.rb'

class Ship
  attr_reader :length

  def initialize(length)
    @length = length
  end

  def take_hit
    @length -= 1
  end

  def sunk
    if @length == 0
      true
    else
      false
    end
  end
end
