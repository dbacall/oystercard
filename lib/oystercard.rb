require_relative "station.rb"
require_relative "journey"


class Oystercard
  attr_reader :balance, :maximum

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(maximum = MAXIMUM)
  @balance = 0
  @maximum = maximum
  @journey = Journey.new
  @current_station = Station.new("name")
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

    @current_station.name = entry_station
    @journey.entry_station = @current_station.name
    @journey.add_entry(entry_station)
  end

  def touch_out(exit_station)
    deduct(1)
    @current_station.name = exit_station
    @journey.add_exit(exit_station)
    @journey.journey_logger
  end

  def in_journey?
    !@journey.entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
