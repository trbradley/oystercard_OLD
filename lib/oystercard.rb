class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :exit_station, :journey, :journey_history

  def initialize
    @balance = DEFAULT_BALANCE
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
    @journey = { entry: '', exit: '' }
  end

  def top_up(value)
    max_balance_reached(value)
    @balance += value
  end

  def touch_in(station)
    under_min_balance
    @entry_station = station
    @exit_station = nil
    @journey[:entry] = @entry_station
  end

  def touch_out(fare, exit_station)
    deduct(fare)
    @exit_station = exit_station
    @entry_station = nil
    @journey[:exit] = @exit_station
    @journey_history << @journey
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def max_balance_reached(x)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if
      balance + x > MAXIMUM_BALANCE
    # TODO: CHECK BEST PRACTICE FOR SINGLE RESPONSIBILITY RE FAIL GUARD CLAUSES
  end

  def under_min_balance
    fail 'Insufficient balance' if balance < MINIMUM_CHARGE
  end
end
