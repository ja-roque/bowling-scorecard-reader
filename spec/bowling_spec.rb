require 'rspec'
require_relative '../scorecard/score_card'
require_relative '../game'

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

end