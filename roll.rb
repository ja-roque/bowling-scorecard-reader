class Roll

  attr_accessor :pins, :foul, :display

  def initialize(roll_data)
    @pins = roll_data.to_i
    @display = pins
  end

end