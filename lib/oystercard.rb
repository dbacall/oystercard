require_relative "station"

class Oystercard
  attr_reader :balance, :maximum, :in_journey, :entry_station

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(maximum = MAXIMUM)
  @balance = 0
  @maximum = maximum
  @in_journey = false
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

  def touch_in(station)
    raise "Minimum £1 required to travel" if no_money?
    journey_start(station)
    @in_journey = true
  end

  def touch_out
    deduct(1)
    journey_end
    @in_journey = false
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
