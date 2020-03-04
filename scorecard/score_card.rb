module ScoreCard

  class TextFile

    attr_reader :file

    def initialize(file)
      @file = file
    end

    def parse
      player_score_array = file.split("\n")
      score_pairs = player_score_array.map(&:split)
      score_pairs.each_with_object({}) do |pair, hash|
        hash[pair.first] ||= []
        hash[pair.first] << pair.last
      end
    end

  end

end