require './train.rb'
require './station.rb'
require './route.rb'

puts 'Создание поездов'
train1 = Train.new(777, Train::TYPES[:cargo], 0)
train2 = Train.new(13, Train::TYPES[:cargo], 14)
train3 = Train.new(666, Train::TYPES[:passenger], 13)
puts " #{train1.number}; #{train2.number}; #{train3.number};"
puts 'Создание станций'
station_spb = Station.new('Санкт-Петербург')
station_grodno = Station.new('Гродно')
station_vitebsk = Station.new('Витебск')
station_minsk = Station.new('Минск')
station_pskov = Station.new('Псков')
puts "#{station_spb.name}; #{station_grodno.name}; #{station_vitebsk.name};"
puts "#{station_minsk.name}; #{station_pskov.name}"
puts 'Создание маршрутов'
route_spb_grodno = Route.new(station_grodno, station_spb)
route_grodno_vitebsk = Route.new(station_grodno, station_vitebsk)
route_minsk_spb = Route.new(station_minsk, station_spb)
puts route_spb_grodno
puts route_grodno_vitebsk
puts route_minsk_spb
puts '----------Присвоение 1му поезду маршрута------------------'
train1.get_route = route_spb_grodno
puts train1.route.inspect
train1.route.stations.each do |station|
  puts station.name
end
puts "Начальная станиция #{train1.number}: #{train1.current_station.name}"
puts '----------Присвоение 2му поезду маршрута------------------'
train2.get_route = route_grodno_vitebsk
puts train2.route
train2.route.stations.each do |station|
  puts station.name
end
puts "Начальная станиция #{train2.number}: #{train2.current_station.name}"
puts '----------Присвоение 3му поезду маршрута------------------'
train3.get_route = route_minsk_spb
puts train3.route
train3.route.stations.each do |station|
  puts station.name
end
puts "Начальная станиция #{train3.number}: #{train3.current_station.name}"
puts '----------Тест скорости и прицепки/отцепки вагонов----------'
puts "Текущая скорость поезда #{train1.number} равна #{train1.speed}"
train1.run = 50
puts "Поезд #{train1.number} набрал скорость #{train1.speed}"
puts "У поезда #{train1.number} вагонов: #{train1.quantity_wagon}"
puts "Поезд #{train1.number} прицепляет вагон"
train1.hook_the_carriage
puts "У поезда #{train1.number} вагонов: #{train1.quantity_wagon}"
train1.unhook_the_carriage
puts "Поезд #{train1.number} отцепляет вагон"
puts "У поезда #{train1.number} вагонов: #{train1.quantity_wagon}"
train1.stop!
puts "Поезд #{train1.number} остановился"
puts "Текущая скорость поезда #{train1.number} равна #{train1.speed}"
puts "Поезд #{train1.number} прицепляет вагон"
train1.hook_the_carriage
puts "У поезда #{train1.number} вагонов: #{train1.quantity_wagon}"
puts "Поезд #{train1.number} прицепляет вагон"
train1.hook_the_carriage
puts "У поезда #{train1.number} вагонов: #{train1.quantity_wagon}"
puts "Поезд #{train1.number} отцепляет вагон"
train1.unhook_the_carriage
puts "У поезда #{train1.number} вагонов: #{train1.quantity_wagon}"
puts "Поезд #{train1.number} отцепляет вагон"
train1.unhook_the_carriage
puts "У поезда #{train1.number} вагонов: #{train1.quantity_wagon}"
puts "Поезд #{train1.number} отцепляет вагон"
train1.unhook_the_carriage
puts "У поезда #{train1.number} вагонов: #{train1.quantity_wagon}"
puts "--------Поезда на станции #{station_grodno.name}----------"
station_grodno.trains.each do |train|
  puts train.number
end
cargo_grodno = station_grodno.show_type_trains(:cargo)
puts "-------Грузовые поезда на станции #{station_grodno.name}-------"
cargo_grodno.each do |train|
  puts train.number
end
puts "Кол-во грузовых поездов #{station_grodno.name}:#{cargo_grodno.count}"
puts "--------Поезда на станции #{station_spb.name}----------"
station_spb.trains.each do |train|
  puts train.number
end
puts '-----------Отправка поезда №1-------------'
puts "Поезд #{train1.number} отправляется на следующую станцию"
train1.forward
puts "--------Поезда на станции #{station_grodno.name}----------"
station_grodno.trains.each do |train|
  puts train.number
end
puts "--------Поезда на станции #{station_spb.name}----------"
station_spb.trains.each do |train|
  puts train.number
end
puts "Добавление в маршрут #{route_spb_grodno} станции: #{station_minsk.name}"
route_spb_grodno.add_station(station_minsk)
puts "Тепперь маршрут #{route_spb_grodno} имеет станции:"
train1.route.stations.each do |station|
  puts station.name
end
puts "--------Поезда на станции #{station_grodno.name}----------"
station_grodno.trains.each do |train|
  puts train.number
end
cargo_grodono = station_grodno.show_type_trains(:cargo)
puts "--------Грузовые поезда на станции #{station_grodno.name}----------"
cargo_grodono.each do |train|
  puts train.number
end
puts "Кол-во грузовых поездов #{station_grodno.name}:#{cargo_grodno.count}"
puts "--------Поезда на станции #{station_spb.name}----------"
station_spb.trains.each do |train|
  puts train.number
end
cargo_spb = station_spb.show_type_trains(:cargo)
passenger_spb = station_spb.show_type_trains(:passenger)
puts "--------Грузовые поезда на станции #{station_spb.name}----------"
cargo_spb.each do |train|
  puts train.number
end
puts "Кол-во пассажир-х поездов #{station_spb.name}:#{passenger_spb.count}"
puts "Кол-во грузовых поездов #{station_spb.name}:#{cargo_spb.count}"
puts "--------Поезда на станции #{station_minsk.name}----------"
station_minsk.trains.each do |train|
  puts train.number
end
cargo_minsk = station_minsk.show_type_trains(:cargo)
puts "--------Грузовые поезда на станции #{station_minsk.name}----------"
cargo_minsk.each do |train|
  puts train.number
end
passenger_minsk = station_minsk.show_type_trains(:passenger)
puts "--------Пассажирские поезда на станции #{station_minsk.name}----------"
passenger_minsk.each do |train|
  puts train.number
end
puts "Кол-во пассажир-х поездов #{station_minsk.name}: #{cargo_minsk.count}"
puts "Кол-во пассажир-х поездов #{station_minsk.name}: #{passenger_minsk.count}"
puts '--------Отправка поезда №3----------'
puts "Текущая станция поезда #{train3.number}-#{train3.current_station.name}"
puts "Следущая станция поезда #{train3.number}-#{train3.next_station.name}"
puts "Поезд #{train3.number} отправляется на следующую станцию"
train3.forward
puts "--------Поезда на станции #{station_spb.name}----------"
station_spb.trains.each do |train|
  puts train.number
end
passenger_spb = station_spb.show_type_trains(:passenger)
puts "Кол-во грузовых поездов #{station_spb.name}: #{cargo_spb.count}"
puts "Кол-во пассажир-х поездов #{station_spb.name}: #{passenger_spb.count}"
train3.forward
train3.forward
