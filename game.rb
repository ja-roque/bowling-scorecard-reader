require_relative 'player'

class Game

  attr_reader :players, :score_hash

  def initialize(parsed_score_hash)
    @players = []
    @score_hash = parsed_score_hash
  end

  def create_players
    score_hash.keys.each do |player_name|
      players << Player.new(player_name, score_hash[player_name])
    end
  end

end