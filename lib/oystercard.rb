require_relative "station.rb"
require_relative "journey"


class Oystercard
  attr_reader :balance, :maximum

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(maximum = MAXIMUM)
  @balance = 0
  @maximum = maximum
  @journeys = Journeys.new
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
    deduct(@journeys.entry_penalty)
    @current_station.name = entry_station
    @journeys.entry_station = @current_station.name
    @journeys.add_entry(entry_station)
  end

  def touch_out(exit_station)
    deduct(@journeys.fare)
    @current_station.name = exit_station
    @journeys.add_exit(exit_station)
    @journeys.journey_logger
  end

  def in_journey?
    !@journeys.entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
