class Lane
  DEFAULT_FRAME_COUNT = 10
  attr_accessor :player, :frames

  def initialize(player, len = DEFAULT_FRAME_COUNT)
    @player = player
    @frames = Array.new(len) { Frame.new }
    @frames[-1] = LastFrame.new
  end

  def fill_lane
    score_array = player.scores.dup
    puts score_array.to_s
    @frames.each.with_index(1) do |frame, index|
      while score_array.any?
        frame.frame_number = index
        frame.add_roll score_array.shift
        frame.check
        break if frame.stop_rolling
      end

    end
  end

end