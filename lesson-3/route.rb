require './instancecounter.rb'

class Route
  attr_reader :name, :start_station, :end_station, :stations

  include InstanceCounter

  @@routes = []

  class << self
    def all
      @@routes
    end

    def find(name)
      route = @@routes.find { |r| r.name == name }
     end
  end

  def initialize(name, start_station, end_station)
    @name = name
    @stations = [start_station, end_station]
    @@routes << self
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end
