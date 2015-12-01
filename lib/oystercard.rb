class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90

  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(value)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if
      balance + value > MAXIMUM_BALANCE
    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
