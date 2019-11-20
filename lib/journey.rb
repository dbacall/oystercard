class Journey
  attr_accessor :entry_station, :exit_station, :journeys_log

  def initialize
    @entry_station
    @exit_station
    @journeys_log = []
    @current_journey = {"Entry station": nil,"Exit station": nil}
  end

  def add_entry(entry_station)
    @entry_station = entry_station
    @current_journey[:"Entry station"] = entry_station
  end

  def add_exit(exit_station)
    @current_journey[:"Exit station"] = exit_station
    @entry_station = nil
  end

  def journey_logger
    @journeys_log << @current_journey
  end
end
