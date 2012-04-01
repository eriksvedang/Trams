load 'Helper.rb'
load 'Token.rb'

class Lexer
  # keywords = array of symbols that are keywords
  # specials = hash map of strings that should become special symbols
  def initialize(keywords, specials)
    @keywords = keywords
    @specials = specials
  end
  
  # string -> token[]
  def process(source)
    @nr = 0
    words = source.split
    tokens = []
    words.each { |word|
      token_type = analyze(word)
      tokens.push(Token.new(token_type, word))
    }
    return tokens
  end
  private
  # string -> token_type
  def analyze(word)
    special = @specials[word]
    
    if special != nil
      return special
    elsif @keywords.include?(word.to_sym)
      return word.to_sym
    else
      return :name
    end
  end
  
end