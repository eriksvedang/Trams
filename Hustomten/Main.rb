load 'Memory.rb'

#puts "Hello there, what's your name?"
#name = "Erik" # gets.chomp
#puts "Hello #{name}, nice to meet you. Lets wanna make a game together!"
#puts "What is the game going to be about?"

m = Memory.new

pre_knowledge = [
  "animal is noun",
  "dog is animal",
  "poodle is dog",
  "legs is noun",
  "animal has legs",
  "has dog legs",
  "eyes is noun",
  "animal has eyes",
  "dog has tail",
  "what has dog",
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