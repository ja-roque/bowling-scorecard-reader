require_relative 'roll'

class Frame

  attr_accessor :score, :stop_rolling, :rolls, :frame_number, :strike, :spare

  def initialize
    @rolls = []
  end

  def add_roll(roll_data)
    rolls << Roll.new(roll_data)
  end

  def check
    num_rolls = rolls.length
    @stop_rolling = if rolls[0].strike?
                      @strike = true
                    elsif num_rolls > 1 && (rolls[0].pins + rolls[1].pins == 10)
                      @spare = true
                      rolls[1].spare!
                    elsif num_rolls > 1 && (rolls[0].pins + rolls[1].pins != 10)
                      true
                    end
  end

end