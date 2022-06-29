MIN_GROWTH = 110
puts 'Enter your name'
name = gets.strip
puts 'Enter your growth'
growth = gets.to_i
weight = (growth - MIN_GROWTH) * 1.15
if weight.positive?
  puts "Good afternoon, #{name}. Your weight is #{weight}"
else
  puts 'Your weight is already optimal'
end