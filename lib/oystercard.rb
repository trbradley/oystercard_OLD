class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :journey, :journey_history

  def initialize
    @balance = DEFAULT_BALANCE
    @journey_history = []
    @journey = { entry: '', exit: '' }
  end

  def top_up(value)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if
      max_balance_reached(value)
    @balance += value
  end

  def touch_in(station)
    fail 'Insufficient balance' if under_min_balance
    @journey[:entry] = station
    @journey[:exit] = ''
  end

  def touch_out(fare, exit_station)
    deduct(fare)
    @journey[:entry] = ''
    @journey[:exit] = exit_station
    @journey_history << @journey
  end

  def in_journey?
    @journey[:entry] != ''
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def max_balance_reached(x)
    balance + x > MAXIMUM_BALANCE
  end

  def under_min_balance
    balance < MINIMUM_CHARGE
  end
end
