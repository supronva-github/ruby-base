letters = ('а'..'я')
vowels_letters = %w[а е ё и о у ы э ю я]
ordinal_number_vowels_letters = {}
letters.each.with_index(1) do |letter, count|
  ordinal_number_vowels_letters[letter] = count if vowels_letters.include?(letter)
end
puts ordinal_number_vowels_letters
