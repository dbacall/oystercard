require_relative "station"
require_relative "journey"
require_relative "journeylog"

class Oystercard
  attr_reader :balance

  MAXIMUM = 90
  MINIMUM = 1

  def initialize(maximum = MAXIMUM)
  @balance = 0
  @maximum = maximum
  @journey_log = Journeylog.new
  end

  def top_up(amount)
    raise "Warning maximum balance is #{MAXIMUM}" if exceeded?(amount)
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
    
    @journey_log.start(entry_station)
    deduct(@journey_log.charge)
  end

  def touch_out(exit_station)
   
    @journey_log.finish(exit_station)
    deduct(@journey_log.charge)
    @journey_log.journey_logger
  end

  def in_journey?
    !@journey.entry_station.nil?
  end

  def print_log
    @journey_log.journey_log
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
