purchases = {}
amount_of_purchases = 0

loop do
  puts 'Введите название товара'
  name = gets.strip
  break if name == 'стоп'

  puts 'Введите цену товара'
  price = gets.to_f
  puts 'Введите количество товара'
  quantity = gets.to_f
  purchases[name] = { price: price, quantity: quantity }
end

purchases.each do |product, price_quantity|
  cost_product = price_quantity[:price] * price_quantity[:quantity]
  puts "#{product}: \
  цена - #{price_quantity[:price]}, количество - #{price_quantity[:quantity]}"
  puts "Cтоимость товара #{product} равна #{cost_product}"
  amount_of_purchases += cost_product
end

puts "Общая стоимость заказа равна #{amount_of_purchases}"
