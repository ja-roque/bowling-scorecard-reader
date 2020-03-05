require 'rspec'
require_relative '../scorecard/score_card'
require_relative '../game'
require_relative '../player'
require_relative '../lane'
require_relative '../frame'
require_relative '../last_frame'
require_relative '../bowling_error'

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
    player = Player.new(model_score_hash.keys.first, model_score_hash[model_score_hash.keys.first])
    player.build_lane
    expect(player.lane).to be_a(Lane)

  end

  it 'Lanes should contain 10 frames' do
    player = Player.new(model_score_hash.keys.first, model_score_hash[model_score_hash.keys.first])
    player.build_lane
    expect(player.lane.frames).to all(be_a(Frame))

  end

  it 'Frames should be able to append their rolls' do
    frame = Frame.new
    2.times do
      frame.add_roll('10')
    end

    expect(frame.rolls).to all(be_a(Roll))
  end

  it 'All frames from a lane should have 3 or less rolls but more than 0' do
    player = Player.new(model_score_hash.keys.first, model_score_hash[model_score_hash.keys.first])
    player.build_lane
    expect(player.lane.frames.map { |frame| frame.rolls.length }).to all(be <= 3 || be > 0)

  end

  it 'should not allow invalid pinfall values' do
    invalids = %w[10 3 23 f U 0 -2 a d4]
    expect { invalids.each { |invalid_val| Roll.new(invalid_val) } }.to raise_error BowlingError

  end

  it 'should add to 0 when all pinfalls for the lane are 0' do
    player = Player.new('Joe', ('0' * 20).split(''))
    player.build_lane
    expect(player.lane.frames.last.score).to be 0

  end

  it 'should add to 0 when all pinfalls for the lane are F' do
    player = Player.new('Joe', ('F' * 20).split(''))
    player.build_lane
    expect(player.lane.frames.last.score).to be 0

  end

  it 'should add to 300 when all pinfalls for the lane are 10' do
    player = Player.new('Joe', ('10,' * 12).split(','))
    player.build_lane

    expect(player.lane.frames.last.score).to be 300

  end

  it 'should not allow too many pinfall values' do
    fake_scorecard = ("cheater 9 \n" * 22)
    scorecard = ScoreCard::TextFile.new('sample.txt')
    scorecard.scorecard_file = fake_scorecard
    expect { scorecard.parse }.to raise_error BowlingError
  end

  it 'should not allow too little pinfall values' do
    fake_scorecard = ("cheater 9 \n" * 9)
    scorecard = ScoreCard::TextFile.new('sample.txt')
    scorecard.scorecard_file = fake_scorecard
    expect { scorecard.parse }.to raise_error BowlingError
  end

end