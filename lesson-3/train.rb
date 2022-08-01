require './manufacturer.rb'
require './instancecounter.rb'

class Train
  attr_reader :current_station_id, :route, :speed, :type, :number, :wagons

  include Manufacturer
  include InstanceCounter

  @@trains = {}

  class << self
    def find(number)
      @@trains[number]
    end
  end

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
    @route = []
    @current_station_id = 0
    @@trains[number] = self
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
    return 'Вы на начальной станции' if first_station?

    @route.stations[current_station_id - 1]
  end

  def next_station
    return 'Вы на конечной станции' if last_station?

    @route.stations[current_station_id + 1]
  end

  def forward
    return 'Вы на конечной станции' if last_station?

    departure
    @current_station_id += 1
    arrival
  end

  def backward
    return 'Вы на начальной станции' if first_station?

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
end
