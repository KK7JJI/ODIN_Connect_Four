require_relative './display'

arr = Array.new(7) { Array.new(6) { |i| i } }
puts ConnectFour::GameDisplay.print_game(arr)

arr = Array.new(7) { Array.new(6) { rand(1...10) } }
puts ConnectFour::GameDisplay.print_game(arr)

arr = Array.new(7) { Array.new(6) { 'O' } }
puts ConnectFour::GameDisplay.print_game(arr)

arr = Array.new(7) { Array.new(6) { 'X' } }
puts ConnectFour::GameDisplay.print_game(arr)

arr = []
arr << []
arr << (0...1).to_a
arr << (0...2).to_a
arr << (0...3).to_a
arr << (0...4).to_a
arr << (0...5).to_a
arr << (0...6).to_a

puts ConnectFour::GameDisplay.print_game(arr)
