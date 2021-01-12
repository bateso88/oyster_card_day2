require_relative 'journey.rb'

class OysterCard
  attr_reader :balance, :list_of_journeys, :current_journey

  BALANCE_LIMIT = 90
  MINIMUM_AMOUNT = 1

  def initialize(balance = 0)
    @balance = balance
    @list_of_journeys = []
    @current_journey = nil
  end

  def top_up(value)
    fail "Cannot exceed £#{BALANCE_LIMIT} limit." if balance + value > BALANCE_LIMIT
    @balance += value
  end

  def in_journey?
    @current_journey != nil
  end

  def touch_in(entry_station)
    fail "Need to have at least £#{MINIMUM_AMOUNT}." if balance < MINIMUM_AMOUNT
    @current_journey = Journey.new(entry_station)
    current_journey.entry_station
  end

  def touch_out(station)
    deduct(MINIMUM_AMOUNT)
    current_journey.exit_station = station
    @list_of_journeys << current_journey
    @current_journey = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

end
