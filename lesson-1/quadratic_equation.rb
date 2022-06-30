puts 'Enter coefficients a'
a = gets.to_f
puts 'Enter coefficients b'
b = gets.to_f
puts 'Enter coefficients c'
c = gets.to_f
discriminant = (b**2 - 4 * a * c).round(2)
if discriminant.positive?
  sqrt_discriminant = Math.sqrt(discriminant)
  x1 = ((-b + sqrt_discriminant) / (2 * a)).round(2)
  x2 = ((-b - sqrt_discriminant) / (2 * a)).round(2)
  puts "Discriminant = #{discriminant} and has 2 roots: #{x1} и #{x2}"
elsif discriminant.zero?
  x = (-b / (2 * a)).round(2)
  puts "Discriminant = #{discriminant} and has 2 identical roots equal:: #{x}"
else
  puts 'No roots'
end
