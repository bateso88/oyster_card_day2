class Journey

  attr_reader :entry_station
  attr_accessor :exit_station

  PENALTY_FARE = 6
  MINIMUM_AMOUNT = 1

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def current?
    exit_station == nil
  end

  def fare
    if exit_station == "Penalty fare"
      PENALTY_FARE
    else
      MINIMUM_AMOUNT
    end
  end

end
