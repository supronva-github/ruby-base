puts 'Enter the sides of the triangle'
number_a = gets.to_f
number_b = gets.to_f
number_c = gets.to_f
side_a, side_b, side_c = [number_a, number_b, number_c].sort
hupotenuse = side_c
if (hupotenuse**2 == side_a**2 + side_b**2) && (side_a != side_b)
  puts 'Triangle rectangular'
elsif (hupotenuse**2 == side_a**2 + side_b**2) && (side_a == side_b)
  puts 'Triangle rectangular'
  puts 'Also, the triangle is isosceles'
elsif (hupotenuse == side_a) && (hupotenuse == side_b)
  puts 'Triangle isosceles and equilateral and not right angled'
else
  puts 'The triangle is not right'
end
