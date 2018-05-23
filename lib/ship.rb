require 'pry'
require './lib/cell.rb'

class Ship
  attr_reader :length, :name, :size, :sink_counter

  attr_accessor :sunk

  def initialize(length, name = "", size = "")
    @length = length
    @name = name
    @size = size
    @sink_counter = 0
  end

  def take_hit
    @length -= 1
  end

  def sunk
    if @sink_counter == 0 && @length == 0
      @sink_counter += 1
      true
    else
      false
    end
  end
end
