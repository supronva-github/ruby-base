require './instancecounter.rb'

class Station
  attr_reader :name, :trains

  include InstanceCounter

  @@stations = []

  class << self
    def all
      @@stations
    end
    
    def find(name)
      station = @@stations.find { |s| s.name == name }
     end
  end

  def initialize(name)
    @name = name
    @trains = []
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
end
