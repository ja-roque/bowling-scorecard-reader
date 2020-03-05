require_relative 'frame'
require_relative 'last_frame'

class Lane
  DEFAULT_FRAME_COUNT = 10
  attr_accessor :player, :frames

  def initialize(player, len = DEFAULT_FRAME_COUNT)
    @player = player
    @frames = Array.new(len) { Frame.new }
    frames[-1] = LastFrame.new
  end

  def fill_lane
    score_array = player.scores.dup
    frames.each.with_index(1) do |frame, index|
      while score_array.any?
        frame.frame_number = index
        frame.add_roll score_array.shift
        frame.check
        break if frame.stop_rolling
      end

    end
  end

  def calculate_scores
    frames.each.with_index do |frame,index|
      frame.score = frames[index - 1].score.to_i + frame.rolls.map(&:pins).reduce(:+)
      frame.score += if frame.strike
                       frames[index + 1].rolls.first.pins + (frames[index + 1].rolls&.at(1)&.pins || frames[index + 2].rolls.first.pins)
                     elsif frame.spare
                       frames[index + 1].rolls.first.pins
                     end.to_i
    end
  end

end