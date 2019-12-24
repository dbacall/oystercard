require_relative "journey"

class Journeylog

  attr_reader :journey_log, :charge

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_log = []
    @charge = 0
    @journey = Journey.new
  end

  def start(entry_station)
    @journey.add_entry(entry_station.name)
    @charge = @journey.entry_penalty
  end

  def finish(exit_station)
    @journey.add_exit(exit_station.name)
    @charge = @journey.fare
    
  end

  def journey_logger
    @journey_log << current_journey
    @journey.current_journey = {"Entry station" => "", "Exit station" => ""}
    @journey_log
  end

  private

  def current_journey
    @journey.current_journey
  end

  

end