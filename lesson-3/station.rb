require './instancecounter'
require './validate'

class Station
  include InstanceCounter
  include Validate

  FORMAT_STATION_NAME = /[a-z]+/i.freeze

  attr_reader :name, :trains

  # rubocop:disable Style/ClassVars
  @@stations = []
  # rubocop:enable Style/ClassVars

  class << self
    def all
      @@stations
    end

    def find(name)
      @@stations.find { |s| s.name == name }
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def arrival_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def show_type_trains(type)
    @trains.select { |train| train.type == type }
  end

  def validate!
    raise ArgumentError, "Name #{name} station is not valid" if name !~ FORMAT_STATION_NAME
    raise ArgumentError, "Station name #{name} is too long" if name.length > 20
    raise ArgumentError, "Station name #{name} is too short" if name.length < 3
  end
end
