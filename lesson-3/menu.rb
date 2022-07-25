require './train.rb'
require './station.rb'
require './route.rb'
require './wagon.rb'
require './cargo_wagon.rb'
require './passenger_wagon.rb'
require './cargo_train.rb'
require './passenger_train.rb'

class Menu
  attr_reader :routes, :trains, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def make_station
    print 'Введите назване станции: '
    name = gets.strip
    station = create_station(name)
    puts "Станция #{station.name} - создана"
  end

  def show_all_stations
    @stations.each do |station|
      puts station.name
    end
  end

  def show_trains_at_station
    print 'Введите станцию: '
    station_name = gets.strip
    station = find_station(station_name)
    station.trains.each do |train|
      puts train.number
    end
  end

  def make_train
    print 'Введите тип поезда: '
    type = gets.strip.to_sym
    print 'Введите номер поезда: '
    number = gets.strip
    train = create_train(type, number)
    puts "Поезд #{train} - создан"
  end

  def manage_routes
    print <<~MENU
      Укажите номер действия:
      1 - Создать маршрут
      2 - Добавить станцию в маршрут
      3 - Удалить станцию в маршруте
      4 - Посмотреть все маршруты
    MENU
    action = gets.to_i
    case action
    when 1
      print 'Введите имя маршрута: '
      route_name = gets.strip
      print 'Введите начальную станцию: '
      start_station = gets.strip
      print 'Введите конечную станцию: '
      end_station = gets.strip
      route = create_route(route_name, start_station, end_station)
      puts "Маршрут #{route.name} - создан"
    when 2
      print 'Введиите имя маршрута: '
      route_name = gets.strip
      print 'Введите имя станции: '
      station_name = gets.strip
      add_station_in_route(route_name, station_name)
    when 3
      print 'Введите имя маршрута: '
      route_name = gets.strip
      print 'Введите имя станции: '
      station_name = gets.strip
      delete_station_in_route(route_name, station_name)
    when 4
      puts @routes
    end
  end

  def manage_moving_the_train
    print <<~MENU
      Укажите номер действия:
      1 - Отправить поезд вперед по маршруту
      2 - Отправить поезд назад по маршруту
      3 - Посмотреть текущую станцию поезда
      4 - Посмотреть предыдущую станцию поезда
      5 - Посмотреть следующую станцию поезда
    MENU
    action = gets.to_i
    print 'Введите номер поезда: '
    train_number = gets.strip
    case action
    when 1
      forward_train(train_number)
    when 2
      backward_train(train_number)
    when 3
      current_station_train(train_number)
    when 4
      previous_station_train(train_number)
    when 5
      next_station_train(train_number)
    end
  end

  def assign_route_to_train
    print 'Введите номер поезда: '
    train_number = gets.strip
    print 'Введите маршрут: '
    route_name = gets.strip
    add_route_to_train(train_number, route_name)
  end

  def manage_wagon_the_train
    print <<~MENU
      Укажите номер действия:
      1 - Прицепить грузовой/пассажирский вагон
      2 - Отцепить вагон
    MENU
    action = gets.to_i
    print 'Введите номер поезда: '
    train_number = gets.strip
    case action
    when 1
      print 'Введите тип вагона: '
      type_wagon = gets.strip.to_sym
      hook_the_wagon_to_train(train_number, type_wagon)
    when 2
      unhook_wagon_the_train(train_number)
    end
  end

  private

  def create_station(name)
    station = Station.new(name)
    @stations << station
    station
  end

  def current_station_train(number)
    train = find_train(number)
    train.current_station
  end

  def previous_station_train(number)
    train = find_train(number)
    train.previous_station
  end

  def next_station_train(number)
    train = find_train(number)
    train.next_station
  end

  def create_train(type, number)
    @trains <<
      case type
      when :cargo
        CargoTrain.new(number)
      when :passenger
        PassengerTrain.new(number)
      end
  end

  def unhook_wagon_the_train(number)
    train = find_train(number)
    train.unhook_the_wagon
  end

  def hook_the_wagon_to_train(train_number, type_wagon)
    train = find_train(train_number)
    case type_wagon
    when :cargo
      train.hook_the_wagon(CargoWagon.new)
    when :passenger
      train.hook_the_wagon(PassengerWagon.new)
    end
  end

  def backward_train(number)
    train = find_train(number)
    train.backward
  end

  def forward_train(number)
    train = find_train(number)
    train.forward
  end

  def create_route(name, start_station, end_station)
    start_station = find_station(start_station)
    end_station = find_station(end_station)
    route = Route.new(name, start_station, end_station)
    @routes << route
    route
  end

  def add_station_in_route(route_name, station_name)
    route = find_route(route_name)
    station = find_station(station_name)
    route.add_station(station)
  end

  def delete_station_in_route(route_name, station_name)
    route = find_route(route_name)
    station = find_station(station_name)
    route.delete_station(station)
  end

  def add_route_to_train(train_number, route_name)
    train = find_train(train_number)
    route = find_route(route_name)
    train.get_route = route
  end

  def find_station(name)
    station = @stations.find { |s| s.name == name }
    return puts "Такой станции #{name} - нету" unless station

    station
  end

  def find_train(number)
    train = @trains.find { |t| t.number == number }
    return puts "Такого поезда #{number} - нету" unless train

    train
  end

  def find_route(name)
    route = @routes.find { |r| r.name == name }
    return puts "Такого маршрута #{name} - нету" unless route

    route
  end
end
