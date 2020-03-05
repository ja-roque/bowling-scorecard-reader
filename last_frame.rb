class LastFrame < Frame
  DEFAULT_ROLL_COUNT = 3

  def check
    num_rolls = rolls.length
    @stop_rolling = if num_rolls >= 3
                      rolls[2].spare! if rolls[-1].pins + rolls[-2].pins == 10
                      true
                    elsif num_rolls > 1 && (rolls[0].pins + rolls[1].pins == 10)
                      rolls[1].spare!
                    elsif num_rolls > 1 && !rolls[0].strike? && (rolls[0].pins + rolls[1].pins != 10)
                      true
                    end
  end

end