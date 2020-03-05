require_relative 'lane'

class Player
  attr_accessor :name, :scores, :lane

  def initialize(name, scores)
    @name = name
    @scores = scores
  end

  def build_lane
    @lane = Lane.new self
    lane.fill_lane
  end

end