class Oystercard
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :in_journey
  alias_method :in_journey?, :in_journey

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(value)
    max_balance_reached(value)
    @balance += value
  end

  def deduct(fare)
    @balance -= fare
  end

  def touch_in
    under_min_balance
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def max_balance_reached(x)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if
      balance + x > MAXIMUM_BALANCE
      # TODO: CHECK BEST PRACTICE FOR SINGLE RESPONSIBILITY RE FAIL GUARD CLAUSES
  end

  def under_min_balance
    fail 'Insufficient balance' if balance < MINIMUM_BALANCE
  end
end
