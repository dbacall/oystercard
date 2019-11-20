require_relative "station"

class Oystercard
  attr_reader :balance, :maximum, :entry_station, :journeys_log

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(maximum = MAXIMUM)
  @balance = 0
  @maximum = maximum
  @entry_station 
  @journeys_log = []
  @current_journey = {}
  end

  def top_up(amount)
    raise "Warning maximum balance is #{@maximum}" if exceeded?(amount)
    @balance += amount
  end

  def exceeded?(amount)
    (@balance + amount) > @maximum
  end

  def no_money?
    @balance < MINIMUM
  end

  def touch_in(entry_station)
    raise "Minimum £1 required to travel" if no_money?
    journey_start(entry_station)
    @current_journey[:"Entry station"] = entry_station
  end

  def touch_out(exit_station)
    deduct(1)
    @current_journey[:"Exit station"] = exit_station
    @journeys_log << @current_journey
    journey_end
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def journey_start(station)
    @entry_station = station
  end

  def journey_end
    @entry_station = nil
  end
end
