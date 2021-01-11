class Oystercard
  attr_reader :balance

  LIMIT_CONSTANT = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(value)
    fail "Limit of #{LIMIT_CONSTANT} reached" if @balance + value > LIMIT_CONSTANT
    @balance += value
  end

end
