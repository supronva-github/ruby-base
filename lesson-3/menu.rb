require './train'
require './station'
require './route'
require './wagon'
require './cargo_wagon'
require './passenger_wagon'
require './cargo_train'
require './passenger_train'

class Menu
  def make_station
    name = input_station_name
    station = create_station(name)
  rescue ArgumentError => e
    show_exception(e)
    retry
  else
    puts "Станция #{station.name} - создана"
  end

  def show_all_stations
    all_stations.each { |station| puts station.name }
  end

  def show_all_routes
    all_routes.each { |route| puts route.name }
  end

  def show_trains_at_station
    station_name = input_station_name
    station = find_station(station_name)
  rescue ArgumentError => e
    show_exception(e)
  else
    station.trains_list do |train|
      puts "Номер поезда: #{train.number}, Тип поезда: #{train.class}, Количество вагонов: #{train.wagons.count}"
    end
  end

  def make_train
    type = input_type_wagon
    number = input_train_number
    train = create_train(type, number)
  rescue ArgumentError => e
    show_exception(e)
    retry
  else
    puts "Поезд #{train} - создан"
  end

  def manage_routes
    menu_manage_routes
    action = gets.to_i
    case action
    when 1
      route_name = input_route_name
      start_station = input_start_station
      end_station = input_end_station
      route = create_route(route_name, start_station, end_station)
      puts "Маршрут #{route.name} - создан"
    when 2
      route_name = input_route_name
      station_name = input_station_name
      add_station_in_route(route_name, station_name)
    when 3
      route_name = input_route_name
      station_name = input_station_name
      delete_station_in_route(route_name, station_name)
    when 4
      show_all_routes
    end
  rescue ArgumentError => e
    show_exception(e)
  end

  def manage_moving_the_train
    menu_manage_moving_the_train
    action = gets.to_i
    train_number = input_train_number
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
    train_number = input_train_number
    route_name = input_route_name
    add_route_to_train(train_number, route_name)
  rescue ArgumentError => e
    show_exception(e)
  else
    puts "Маршрут #{route_name} присвоен поезду #{train_number}"
  end

  def manage_wagon_the_train
    menu_manage_wagon_the_train
    action = gets.to_i
    train_number = input_train_number
    case action
    when 1
      type_wagon = input_type_wagon
      hook_the_wagon_to_train(train_number, type_wagon)
    when 2
      unhook_wagon_the_train(train_number)
    when 3
      train = find_train(train_number)
      train.wagons_list { |wagon| puts wagon }
    end
  rescue ArgumentError => e
    show_exception(e)
  end

  def wagon_loading_control
    print 'Введите номер поезда: '
    train_number = gets.strip
    train = find_train(train_number)
    case train
    when CargoTrain
      print 'Загрузить обьем: '
      volume = gets.to_i
      print 'Введите номер вагона: '
      wagon_number = gets.to_i
      load_wagon(train_number, volume, wagon_number)
    when PassengerTrain
      print 'Забронировать место: '
      seat = gets.to_i
      print 'Введите номер вагона: '
      wagon_number = gets.to_i
      seat_reservation(train_number, seat, wagon_number)
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
    Route.new(name, start_station, end_station)
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

  def find_wagon(train_number, wagon_number)
    raise ArgumentError, 'The wagon cannot be empty' if wagon_number.zero?

    train = find_train(train_number)
    raise ArgumentError, 'There is no such wagon' if train.wagons.count < wagon_number

    train.wagons[wagon_number - 1]
  end

  def load_wagon(train_number, volume, wagon_number)
    wagon = find_wagon(train_number, wagon_number)
    wagon.fill!(volume)
  end

  def seat_reservation(train_number, seat, wagon_number)
    wagon = find_wagon(train_number, wagon_number)
    wagon.take_seat!(seat)
  end

  def show_exception(exception)
    puts " #{exception.message} "
  end

  def input_station_name
    print 'Введите назване станции: '
    gets.strip
  end

  def input_start_station
    print 'Введите начальную станцию: '
    gets.strip
  end

  def input_end_station
    print 'Введите конечную станцию: '
    gets.strip
  end

  def input_train_number
    print 'Введите номер поезда: '
    gets.strip
  end

  def input_route_name
    print 'Введите название маршрута: '
    gets.strip
  end

  def input_type_wagon
    print 'Введите тип(cargo или passenger) поезда: '
    gets.strip.to_sym
  end

  def menu_manage_routes
    print <<~MENU
      Укажите номер действия:
      1 - Создать маршрут
      2 - Добавить станцию в маршрут
      3 - Удалить станцию в маршруте
      4 - Посмотреть все маршруты
    MENU
  end

  def menu_manage_moving_the_train
    print <<~MENU
      Укажите номер действия:
      1 - Отправить поезд вперед по маршруту
      2 - Отправить поезд назад по маршруту
      3 - Посмотреть текущую станцию поезда
      4 - Посмотреть предыдущую станцию поезда
      5 - Посмотреть следующую станцию поезда
    MENU
  end

  def menu_manage_wagon_the_train
    print <<~MENU
      Укажите номер действия:
      1 - Прицепить грузовой/пассажирский вагон
      2 - Отцепить вагон
    MENU
  end
end
