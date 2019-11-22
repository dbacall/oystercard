class Station
  attr_accessor :name, :zones

  ZONE_DATA = {
    1 => "Liverpool Street",
    2 => "Farringdon",
    3 => "Kilburn",
    4 => "Edgware"
    }

  def initialize(name = "")
    @name = name
    @zones = ZONE_DATA
  end

  def update_station(station)
    @name = station
  end

end
