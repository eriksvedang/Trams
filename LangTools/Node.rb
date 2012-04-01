
class Node
  attr_accessor :children, :token
  
  def initialize(token)
    @children = []
    @token = token
  end
  
  def add_child(node)
    @children.push(node)
  end
  
  def inspect
    if @children.size > 0
      child_string = ""
      @children.each { |child|
        child_string << child.inspect
        unless child == @children.last
          child_string << ", "
        end
      }
      "(#{@token.token_type} #{child_string})"
    else
      "(#{@token.token_type})"
    end
  end
end