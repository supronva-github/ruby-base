require './menu'

menu = Menu.new

loop do
  puts <<~MENU
    Укажите номер действия:
    1 - Создать станцию
    2 - Создать поезд
    3 - Управление маршрутом
    4 - Назначить маршрут поезду
    5 - Управление передвижением поезда
    6 - Просмотреть список станций
    7 - Просмотреть список поездов на станции
    8 - Оцепить/Прицепить вагон к поезду
    9 - Выйти из программы
  MENU
  action = gets.to_i
  case action
  when 1
    menu.make_station
  when 2
    menu.make_train
  when 3
    menu.manage_routes
  when 4
    menu.assign_route_to_train
  when 5
    menu.manage_moving_the_train
  when 6
    menu.show_all_stations
  when 7
    menu.show_trains_at_station
  when 8
    menu.manage_wagon_the_train
  when 9
    exit
  end
end
