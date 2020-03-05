require_relative 'scorecard/score_card'
require_relative 'game'

class Bowling
  attr_accessor :file

  def initialize(scorecard_file)
    puts '* Reading the scorecard file *'
    @file = ScoreCard::TextFile.new(scorecard_file)
  end

  def start
    file.read
    player_scores_hash = file.parse
    game = Game.new(player_scores_hash)
    game.create_players

    ScoreCard::ParsedData.new(game).print_table
  end

end