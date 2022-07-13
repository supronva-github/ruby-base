class Route
  attr_accessor :start_station, :end_station, :stations

  def initialize(start_station, end_station)
   @stations = [@start_station, @end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
