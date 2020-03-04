class Lane
  DEFAULT_FRAME_COUNT = 10
  attr_accessor :player, :frames

  def initialize(player, len = DEFAULT_FRAME_COUNT)
    @player = player
    @frames = Array.new(len) { Frame.new }
    @frames[-1] = LastFrame.new
  end

end