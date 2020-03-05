class BowlingError < StandardError
  def initialize(msg="Scorecard parse error", details="No Details")
    super(msg)
  end
end