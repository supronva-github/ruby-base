require './manufacturer.rb'
require './instancecounter.rb'
require './validate.rb'

class Train
  FORMAT_TRAIN_NUMBER = /^\w{3}-?\w{2}$/i

  attr_reader :current_station_id, :route, :speed, :type, :number, :wagons

  include Manufacturer
  include InstanceCounter
  include Validate

  @@trains = []

  class << self
    def all
      @@trains
    end
    
    def find(number)
     train = @@trains.find { |t| t.number == number }
    end
  end

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @route = []
    @current_station_id = 0
    validate!
    @@trains << self
    register_instance
  end

  def stop!
    @speed = 0
  end

  def run=(speed)
    @speed += speed
  end

  def hook_the_wagon(wagon)
    if valid_wagon?(wagon) && stop?
      @wagons << wagon
    else
      puts 'Нельзя текущий вагон присоединить к поезду'
    end
  end

  def unhook_the_wagon
    @wagons.pop if stop? && !@wagons.empty?
  end

  def get_route=(route)
    return unless route

    @route = route
    arrival
  end

  def current_station
    @route.stations[current_station_id]
  end

  def previous_station
    raise ArgumentError, 'Вы на начальной станции' if first_station?

    @route.stations[current_station_id - 1]
  end

  def next_station
    raise ArgumentError, 'Вы на конечной станции' if last_station?

    @route.stations[current_station_id + 1]
  end

  def forward
    raise ArgumentError, 'Вы на конечной станции' if last_station?

    departure
    @current_station_id += 1
    arrival
  end

  def backward
    raise ArgumentError, 'Вы на начальной станции' if first_station?

    departure
    @current_station_id -= 1
    arrival
  end

  private

  def arrival
    @route.stations[@current_station_id].arrival_train(self)
  end

  def departure
    @route.stations[@current_station_id].departure_train(self)
  end

  def stop?
    @speed.zero?
  end

  def last_station?
    current_station == @route.stations.last
  end

  def first_station?
    current_station == @route.stations.first
  end

  def valid_wagon?(wagon)
    wagon.instance_of?(type_wagon)
  end

  def validate!
    raise ArgumentError, "Number #{number} train is not valid" if number !~ FORMAT_TRAIN_NUMBER
  end
end