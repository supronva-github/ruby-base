require './instancecounter.rb'

class Route
  attr_reader :name, :start_station, :end_station, :stations

  include InstanceCounter

  def initialize(name, start_station, end_station)
    @name = name
    @stations = [start_station, end_station]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
