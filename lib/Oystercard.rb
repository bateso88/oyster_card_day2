class Oystercard
  attr_reader :balance

  LIMIT_CONSTANT = 90

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(value)
    fail "Limit of #{LIMIT_CONSTANT} reached" if @balance + value > LIMIT_CONSTANT
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end 

end
