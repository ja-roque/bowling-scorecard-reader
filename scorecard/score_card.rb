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

end