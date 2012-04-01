load 'Memory.rb'

#puts "Hello there, what's your name?"
#name = "Erik" # gets.chomp
#puts "Hello #{name}, nice to meet you. Lets wanna make a game together!"
#puts "What is the game going to be about?"

m = Memory.new
m.load("save.txt")

system("clear")

while true
  input = gets.chomp
  if input == "q"
    break
  elsif input == "d"
    m.dump
  elsif input == "r"
    load 'Memory.rb'
  elsif input == "s"
    m.save("save.txt")
  elsif input == "l"
    m.load("save.txt")
  else
    puts m.analyze(input)  
  end
end

m.save("save.txt")