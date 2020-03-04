require 'rspec'
require_relative '../scorecard/score_card'
require_relative '../game'
require_relative '../player'
require_relative '../lane'
require_relative '../frame'
require_relative '../last_frame'

describe 'Bowling' do

  let(:model_score_hash) do
    {
        'Jeff' => %w[10 7 3 9 0 10 0 8 8 2 F 6 10 10 10 8 1],
        'John' => %w[3 7 6 3 10 8 1 10 10 9 0 7 3 4 4 10 9 0]
    }
  end

  it 'Should read the file' do

    scorecard = ScoreCard::TextFile.new('sample.txt')
    scorecard_file = scorecard.read
    expect(scorecard_file).to be_a(String)

  end

  it 'Should parse text file to hash' do
    scorecard = ScoreCard::TextFile.new('sample.txt')
    scorecard.read
    file_hash = scorecard.parse
    expect(file_hash).to eq(model_score_hash)

  end

  it 'Should create Player objects from hash' do
    game = Game.new(model_score_hash)
    game.create_players
    expect(game.players).to all(be_a(Player))

  end

  it 'Player should build its lane' do
    player = Player.new(model_score_hash.keys.first, model_score_hash.first)
    player.build_lane
    expect(player.lane).to be_a(Lane)

  end

  it 'Lanes should contain 10 frames' do
    player = Player.new(model_score_hash.keys.first, model_score_hash.first)
    player.build_lane
    expect(player.lane.frames).to all(be_a(Frame))

  end

end