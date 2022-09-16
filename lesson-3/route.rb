require './instancecounter.rb'
require './validate.rb'

class Route
  FORMAT_ROUTE_NAME = /[a-z]+-[a-z]/i

  attr_reader :name, :start_station, :end_station, :stations

  include InstanceCounter
  include Validate

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
    validate!
    @@routes << self
    register_instance
  end

  def add_station(station)
    raise ArgumentError, 'Station is present on the route' if stations.include?(station)

    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def validate!
    raise ArgumentError, "Name #{name} route is not valid" if name !~ FORMAT_ROUTE_NAME
    raise ArgumentError, 'Start station coincides with end station' if @stations[0] == @stations[-1]
  end
end
