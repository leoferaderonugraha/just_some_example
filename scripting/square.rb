n = 5
time = 0
square = (n * 2) - 1

(square).times do |x|
  print n

  down = n - time
  up = x - n + 2

  if x <= n - 1
    (square - n).times do
      print down
    end
    time += 1

  elsif x == square - 1
    (square - n).times do
      print n
    end

  else
    (square - n).times do
      print up
    end
  end

  puts n
end
