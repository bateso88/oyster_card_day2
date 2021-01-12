class OysterCard
  attr_reader :balance, :entry_station, :list_of_journeys

  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1

  def initialize(balance = 0)
    @balance = balance
    @entry_station = nil
    @list_of_journeys = []
  end

  def top_up(value)
    fail "Cannot exceed £#{BALANCE_LIMIT} limit." if balance + value > BALANCE_LIMIT
    @balance += value
  end

  def in_journey?
    entry_station != nil
  end

  def touch_in(station)
    fail "Need to have at least £#{MINIMUM_AMOUNT}." if balance < MINIMUM_AMOUNT
    @entry_station = station

  end

  def touch_out(station)
    deduct(MINIMUM_AMOUNT)
    @list_of_journeys << {entry_station: entry_station, exit_station: station}
    @entry_station = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

end
