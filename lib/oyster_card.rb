require_relative 'journey.rb'

class OysterCard
  attr_reader :balance, :list_of_journeys, :current_journey

  BALANCE_LIMIT = 90

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
    current_journey != nil
  end

  def touch_in(station)
    fail "Need to have at least £#{Journey::MINIMUM_AMOUNT}." if balance < Journey::MINIMUM_AMOUNT
    end_previous_journey_if_never_touched_out
    start_new_journey(station)
  end

  def end_previous_journey_if_never_touched_out
    touch_out("Penalty fare") if in_journey?
  end

  def start_new_journey(station)
    @current_journey = Journey.new(station)
    current_journey.entry_station
  end

  def touch_out(station)
    current_journey.exit_station = station
    end_journey
  end

  def end_journey
    deduct(current_journey.fare)
    @list_of_journeys << current_journey
    @current_journey = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

end
