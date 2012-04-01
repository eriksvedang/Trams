load 'Lexer.rb'
require "pp" # pretty print

source = "
  foo x = 4
  for {
    int i = 10 + x
  }
"

keywords = [:for]
specials = { 
  "{" => :l_bracket, 
  "}" => :r_bracket,
  "=" => :equals,
  "+" => :plus
}

lexer = Lexer.new(keywords, specials)
tokens = lexer.process(source)

pp tokens