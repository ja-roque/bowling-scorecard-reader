class Roll

  attr_accessor :pins, :foul, :display

  VALID_ROLL_VALS = (0..10).to_a + %W['F','f']

  def initialize(roll_data)
    # Raise BowlingError("Invalid Roll Data #{roll_data}") unless VALID_ROLL_VALS.include? roll_data
    @pins = roll_data.to_i
    @display = pins
  end

  def strike!
    @display = 'X' if strike?
  end

  def spare!
    @display = '/'
  end

  def foul!
    @foul = true
    @display = 'F'
  end

  def identify_roll(roll_data)
    if roll_data.downcase == 'f'
      foul!
    elsif pins.positive? && pins <= 10
      strike!
    elsif pins.zero?
      # Can display 0s as ' - '
    else
      puts 'Raise invalid roll data'
    end
  end

  def strike?
    pins == 10
  end

end