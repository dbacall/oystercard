require_relative "station"

class Journey
  attr_accessor  :journeys_log, :current_journey

  def initialize(entry_station = Station.new(), exit_station = Station.new(""))
    @entry_station = entry_station
    @exit_station = exit_station
    @current_journey = {"Entry station" => "", "Exit station" => ""}
    @zone_tracker = []
  end

  def add_entry(entry_station)
    @zone_tracker[0] = @entry_station.zones.key(entry_station)
    @entry_station.update_station(entry_station)
    @current_journey["Entry station"] = entry_station
  end

  def add_exit(exit_station)
    @zone_tracker[1] = @exit_station.zones.key(exit_station)
    @exit_station.update_station(exit_station)
    @current_journey["Exit station"] = exit_station
  end

  def entry_penalty
    @entry_station.name == "" ? fare = 0 : fare = 6
    
    fare
  end

  def fare
    @entry_station.name == "" ? fare = 6 : fare = zones_crossed
    reset_stations
    fare
  end

  def reset_stations
    @entry_station.update_station("")
    @exit_station.update_station("")
  end

  def zones_crossed
    if @zone_tracker[1] - @zone_tracker[0] > 0
      @zone_tracker[1] - @zone_tracker[0] + 1
    else
      -(@zone_tracker[1] - @zone_tracker[0]) + 1
    end
  end
end
