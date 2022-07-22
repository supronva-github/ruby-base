class Train 
  TYPES = { cargo: :cargo, passenger: :passenger }.freeze

  attr_reader :current_station_id, :route, :speed, :quantity_wagon, :type, :number

  def initialize(number, type, quantity_wagon)
    @number = number
    @type = type
    @quantity_wagon = quantity_wagon
    @speed = 0
    @route = []
    @current_station_id = 0
  end

  def stop!
    @speed = 0
  end

  def run=(speed)
    @speed += speed
  end

  def hook_the_carriage
    return unless stop?

    @quantity_wagon += 1
  end

  def unhook_the_carriage
    return unless stop? && @quantity_wagon.positive?

    @quantity_wagon -= 1
  end

  def get_route=(route)
    @route = route
    arrival
  end

  def current_station
    @route.stations[current_station_id]
  end

  def previous_station
    return if first_station?

    @route.stations[current_station_id - 1]
  end

  def next_station
    return if last_station?

    @route.stations[current_station_id + 1]
  end

  def forward
    return 'Вы на конечной станции' if last_station?

    departure
    @current_station_id += 1
    arrival
  end

  def back_forward
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
end
