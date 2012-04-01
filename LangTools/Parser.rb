load 'Node.rb'

class Parser
  # token[] -> root node
  def process(tokens)
    @tokens = tokens
    ast = Node.new(Token.new(:root, "Root"))
    program(ast)
    return ast
  end

  private 
  
  def program(parent)
    log("program")
    while(@tokens.size > 0)
      statement(parent)
    end
  end

  def statement(parent)
    log("statement")
    node = nil
    
    case @tokens.first.token_type
    when :plus
      node = arithmetic(parent)
    when :minus
      node = arithmetic(parent)
    when :name
      node = name(parent)
    end
    
    if node != nil
      parent.add_child(node)
    end
  end
  
  def arithmetic(parent)
    log("arithmetic")
    new_node = Node.new(consume())
    parent.add_child(new_node)
  end
  
  def name(parent)
    log("name")
    new_node = Node.new(consume())
    parent.add_child(new_node)
  end

  def consume
    first = @tokens.first
    @tokens = @tokens.drop(1)
    return first
  end
  
  def log(msg)
    puts msg
  end
end