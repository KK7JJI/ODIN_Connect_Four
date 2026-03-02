def numbers(n)
  return [n] if n == 0

  arr = numbers(n - 1)
  arr << n
end

puts numbers(10).inspect
