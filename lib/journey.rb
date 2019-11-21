require_relative "station"

class Journey
  attr_accessor :entry_station, :exit_station, :journeys_log, :current_journey

  def initialize
    @entry_station = Station.new(nil)
    @exit_station = Station.new(nil)
    @current_journey = {"Entry station" => nil, "Exit station" => nil}
  end

  def add_entry(entry_station)
    @entry_station.name = entry_station
    @current_journey["Entry station"] = entry_station
  end

  def add_exit(exit_station)
    @exit_station.name = exit_station
    @current_journey["Exit station"] = exit_station
    
    
  end

  def entry_penalty
    @entry_station.name.nil? ? fare = 0 : fare = 6
    reset_stations
    fare
  end

  def fare
    @entry_station.name.nil? ? fare = 6 : fare = 1
    reset_stations
    fare
  end

  def reset_stations
    @entry_station.name = nil
    @exit_station.name = nil
    
  end
end
