require_relative "journey"

class Journeylog

  attr_reader :journey_log, :charge

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_log = []
    @charge = 0
    @journey
  end

  def start(entry_station)
    @journey = @journey_class.new
    
    @journey.add_entry(entry_station)
    @charge = @journey.entry_penalty
  end

  def finish(exit_station)
    
    @journey.add_exit(exit_station)
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