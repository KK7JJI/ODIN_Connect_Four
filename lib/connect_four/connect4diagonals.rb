def diag_coordinates(pos, dir)
  return [pos] if pos[0] == 0 && dir[0] < 0
  return [pos] if pos[1] == 0 && dir[1] < 0
  return [pos] if pos[0] == 5 && dir[0] > 0
  return [pos] if pos[1] == 6 && dir[1] > 0

  arr = func(pos.zip(dir).map { |a, b| a + b }, dir)
  arr << pos
end

def array_diagonals
  arr = []
  (0...7).each do |i|
    arr << func([0, i], [1, 1])
    arr << func([5, i], [-1, -1])
    arr << func([0, i], [1, -1])
    arr << func([5, i], [-1, 1])
  end

  (0...6).each do |i|
    arr << func([i, 0], [1, 1])
    arr << func([i, 6], [-1, -1])
    arr << func([i, 6], [1, -1])
    arr << func([i, 0], [-1, 1])
  end

  arr = arr.select { |row| row.length > 3 }
  puts arr.inspect
  arr.each { |item| puts item.inspect }
end

array_diagonals

puts '(0,i)'
puts ''
(0...7).each do |i|
  p func([0, i], [1, 1])
end

puts ''
puts '(i,0)'
puts ''
(0...6).each do |i|
  p func([i, 0], [1, 1])
end

puts ''
puts '(5,i)'
puts ''
(0...7).each do |i|
  p func([5, i], [-1, -1])
end

puts ''
puts '(i,6)'
puts ''
(0...6).each do |i|
  p func([i, 6], [-1, -1])
end

puts ''
puts '(0,i)'
puts ''
(0...7).each do |i|
  p func([0, i], [1, -1])
end

puts ''
puts '(i,6)'
puts ''
(0...6).each do |i|
  p func([i, 6], [1, -1])
end

puts ''
puts '(5,i)'
puts ''
(0...7).each do |i|
  p func([5, i], [-1, 1])
end

puts ''
puts '(i,0)'
puts ''
(0...6).each do |i|
  p func([i, 0], [-1, 1])
end

# p func([0, 0], [1, 1])
# p func([5, 5], [-1, -1])
# p func([6, 7], [1, 1])
# p func([6, 7], [-1, -1])

1 [4, 5, 1, 3, 2, 3, 3, 5, 4, 2, 2, 1, 3, 5, 1, 7, 6, 6, 6, 7, 7]
2 [4, 3, 2, 4, 5, 1, 4, 3, 4, 6, 2, 1, 2, 5, 5, 1, 6, 6, 7, 7, 7]
