require 'terminal-table'
require_relative '../lane'
require_relative '../bowling_error'

FRAME_COUNT = Lane::DEFAULT_FRAME_COUNT

module ScoreCard

  class TextFile

    attr_reader :filename
    attr_accessor :scorecard_file

    def initialize(filename)
      @filename = filename
    end

    def read
      @scorecard_file = File.read(filename)
    end

    def parse
      player_score_array = scorecard_file.split("\n")
      # player_score_array = scorecard_file.scan(proper_format).flatten # <--- Flexibilidad de entrada acordada en el correo para el bono
      raise BowlingError, "Wrong scorecard text file format, aborting." unless player_score_array.any? { |line| proper_format.match line }

      score_pairs = player_score_array.map(&:split)
      player_scores_hash = score_pairs.each_with_object({}) do |pair, hash|
        hash[pair.first] ||= []
        hash[pair.first] << pair.last
      end

      pinfall_healthcheck player_scores_hash
    end

    private

    def proper_format
      /(\w+?\s\d+|\w+?\s[Ff])/
    end

    def pinfall_healthcheck(player_scores_hash)
      error_message = nil
      player_scores_hash.each do |player, read_scores|
        pinfalls = read_scores.dup
        pinfalls.map!(&:to_i)
        if pinfalls.length > 21 || (pinfalls.length == 21 && pinfalls.last(3).first(2).reduce(:+) < 10)
          error_message = "Too many pinfalls detected for player: #{player}"
        elsif pinfalls.length < 10 || (pinfalls.length == 21 && pinfalls.last(3).first(2).reduce(:+) < 10)
          error_message = "Too little pinfalls detected for player: #{player}"
        end
        raise BowlingError, error_message if error_message
      end

      player_scores_hash
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