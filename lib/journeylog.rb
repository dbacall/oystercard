require_relative "journey"

class Journeylog

  attr_reader :journey_log, :charge

  def initialize
    @journey = Journey.new
    @journey_log = []
    @charge = 0
  end

  def start(entry_station)
    @charge = @journey.entry_penalty
    @journey.add_entry(entry_station)
    
  end

  def finish(exit_station)
    
    @journey.add_exit(exit_station)
    @charge = @journey.fare
    
  end

  def journey_logger
    @journey_log << current_journey
    @journey.current_journey = {"Entry station" => nil, "Exit station" => nil}
    @journey_log
  end

  private

  def current_journey
    @journey.current_journey
  end

  

end