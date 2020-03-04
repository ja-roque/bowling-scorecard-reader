require_relative 'scorecard/score_card'

class Bowling
  attr_accessor :file

  def initialize(scorecard_file)
    puts '* Reading the scorecard file *'
    @file = File.read(scorecard_file)
    start
  end

  def start
    player_scores_hash = ScoreCard::TextFile.new(file).parse
    puts player_scores_hash
  end

end