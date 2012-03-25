load 'Memory.rb'

#puts "Hello there, what's your name?"
#name = "Erik" # gets.chomp
#puts "Hello #{name}, nice to meet you. Lets wanna make a game together!"
#puts "What is the game going to be about?"

m = Memory.new

pre_knowledge = [
  "wing is noun",
  "duck has 2 wing",
  "duck has 3 eye",
  "what has duck",
#  "how many wing has duck"
]

pre_knowledge.each do |s|
  puts "#{s} = #{m.analyze(s)}"
end

while true
  input = gets.chomp
  if input == "q"
    break
  elsif input == "d"
    m.dump
  elsif input == "r"
    load 'Memory.rb'
  else
    puts m.analyze(input)  
  end
end