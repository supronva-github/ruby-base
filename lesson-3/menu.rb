require './train.rb'
require './station.rb'
require './route.rb'
require './wagon.rb'
require './cargo_wagon.rb'
require './passenger_wagon.rb'
require './cargo_train.rb'
require './passenger_train.rb'

class Menu
  def make_station
    print 'Введите назване станции: '
    name = gets.strip
    station = create_station(name)
  rescue ArgumentError => e
    show_exception(e)
    retry
  else
    puts "Станция #{station.name} - создана"
  end

  def show_all_stations
    all_stations.each do |station|
      puts station.name
    end
  end

  def show_all_routes
    all_routes.each do |route|
      puts route.name
    end
  end

  def show_trains_at_station
    print 'Введите станцию: '
    station_name = gets.strip
    station = find_station(station_name)
  rescue ArgumentError => e
    show_exception(e)
  else
    station.trains.each do |train|
      puts train.number
    end
  end

  def make_train
    print 'Введите тип(cargo или passenger) поезда: '
    type = gets.strip.to_sym
    print 'Введите номер поезда: '
    number = gets.strip
    train = create_train(type, number)
  rescue ArgumentError => e
    show_exception(e)
    retry
  else
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
      show_all_routes
    end
  rescue ArgumentError => e
    show_exception(e)
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
  rescue ArgumentError => e
    show_exception(e)
  end

  def assign_route_to_train
    print 'Введите номер поезда: '
    train_number = gets.strip
    print 'Введите маршрут: '
    route_name = gets.strip
    add_route_to_train(train_number, route_name)
  rescue ArgumentError => e
    show_exception(e)
  else
    puts "Маршрут #{route_name} присвоен поезду #{train_number}"
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
      print 'Введите тип(cargo или passenger) вагона: '
      type_wagon = gets.strip.to_sym
      hook_the_wagon_to_train(train_number, type_wagon)
    when 2
      unhook_wagon_the_train(train_number)
    end
  rescue ArgumentError => e
    show_exception(e)
  end

  private

  def create_station(name)
    Station.new(name)
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
    case type
    when :cargo
      CargoTrain.new(number)
    when :passenger
      PassengerTrain.new(number)
    else
      raise ArgumentError, 'This type of train does not exist'
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
    else
      raise ArgumentError, 'This type of wagon does not exist'
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
  
  def all_stations
    Station.all
  end

  def all_routes
    Route.all
  end

  def find_station(name)
    station = Station.find(name)
    raise ArgumentError, "There is no such station #{name}" unless station

    station
  end

  def find_route(name)
    route = Route.find(name)
    raise ArgumentError, "There is no such route #{name}" unless route

    route
  end

  def find_train(number)
    train = Train.find(number)
    raise ArgumentError, "There is no such train #{number}" unless train

    train
  end

  def show_exception(exception)
    puts " #{exception.message} "
  end
end