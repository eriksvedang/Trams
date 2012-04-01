class Token
  attr_accessor :token_type, :text
  
  # token_type is a symbol
  # text is the actual string from the source
  def initialize(token_type, text)
    @token_type = token_type
    @text = text
  end
  
  def inspect
    "<#{@token_type}, '#{@text}'>"
  end
end