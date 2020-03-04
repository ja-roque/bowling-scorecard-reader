require_relative 'roll'

class Frame

  attr_accessor :score, :stop_rolling?, :rolls, :frame_number, :strike, :spare

  def initialize()
    @rolls = []
  end

  def add_roll(roll_data)
    @rolls << Roll.new(roll_data)
  end


end
