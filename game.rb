require_relative 'player'

class Game

  attr_reader :players, :score_hash

  def initialize(parsed_score_hash)
    @players = []
    @score_hash = parsed_score_hash
  end

  def create_players
    score_hash.keys.each do |player_name|
      player = Player.new(player_name, score_hash[player_name])
      player.build_lane
      players << player
    end

  end

end