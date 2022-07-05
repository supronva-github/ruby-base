sum_days = 0
days_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'Введите день'
day = gets.to_i
puts 'Введите месяц'
month = gets.to_i
puts 'Введите год'
year = gets.to_i

days_months.each.with_index(1) do |days, index|
  sum_days += days if index < month
end

number = sum_days + day

if ((year % 400).zero? || (year % 4).zero? && year % 100 != 0) && (month > 2)
  puts "Порядковый номер даты равен: #{number + 1}"
else
  puts "Порядковый номер даты равен: #{number}"
end