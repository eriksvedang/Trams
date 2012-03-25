load 'Memory.rb'

#puts "Hello there, what's your name?"
#name = "Erik" # gets.chomp
#puts "Hello #{name}, nice to meet you. Lets wanna make a game together!"
#puts "What is the game going to be about?"

m = Memory.new

pre_knowledge = [
  "poodle is dog",
  "dog is animal",
  "animal is noun"
]

pre_knowledge.each do |s|
  puts "#{s} = #{m.analyze(s)}"
end

while true
  input = gets.chomp
  if input == "q"
    break
  else
    puts m.analyze(input)  
  end
end