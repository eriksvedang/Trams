load 'Lexer.rb'
load 'Parser.rb'
require "pp" # pretty print

source = "
  + 3 2
"

keywords = [:for]
specials = { 
  "{" => :l_bracket, 
  "}" => :r_bracket,
  "=" => :equals,
  "+" => :plus,
  "-" => :minus,
}

lexer = Lexer.new(keywords, specials)
tokens = lexer.process(source)

puts "Tokens:"
pp tokens

parser = Parser.new
ast = parser.process(tokens)

# root = Node.new(Token.new(:root))
# left = Node.new(Token.new(:left))
# right = Node.new(Token.new(:right))
# root.add_child(left)
# root.add_child(right)

puts "AST:"
puts ast.inspect