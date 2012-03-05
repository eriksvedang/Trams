require 'map'
require 'pathfinder'

map1 = Map.new(10, 8)

map1.set_cost(4, 5, 1)
map1.set_cost(5, 5, 1)
map1.set_cost(6, 5, 1)
map1.set_cost(5, 2, 1)
map1.set_cost(5, 3, 1)
map1.set_cost(5, 4, 1)

map1.print

if map1.outside? 10, 9 then puts "outside!" end

result, path = find_path(map1, [0, 0], [9, 7])

puts "Result: #{result}, path: #{path}"