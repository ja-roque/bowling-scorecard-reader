require 'terminal-table'
require_relative '../lane'

FRAME_COUNT = Lane::DEFAULT_FRAME_COUNT

module ScoreCard

  class TextFile

    attr_reader :filename, :scorecard_file

    def initialize(filename)
      @filename = filename
    end

    def read
      @scorecard_file = File.read(filename)
    end

    def parse
      player_score_array = scorecard_file.split("\n")
      score_pairs = player_score_array.map(&:split)
      score_pairs.each_with_object({}) do |pair, hash|
        hash[pair.first] ||= []
        hash[pair.first] << pair.last
      end
    end

  end

  class ParsedData

    attr_reader :game_data

    def initialize(game)
      @game_data = game
    end

    def print_table
      table = Terminal::Table.new(style: { width: 120 }) do |t|
        t << ['Frame', (1..FRAME_COUNT).to_a].flatten
        t << :separator

        game_data.players.each do |player|
          t.add_separator
          t.add_row [player.name, Array.new(FRAME_COUNT)].flatten

          rolls = player.lane.frames.map(&:rolls).map do |roll|
            roll.map(&:display).join '  '
          end

          t.add_row ['pinfalls', rolls].flatten
          t.add_row ['score', player.lane.frames.map(&:score)].flatten
        end

      end

      puts table
    end

  end

end