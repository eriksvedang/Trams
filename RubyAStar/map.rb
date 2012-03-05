class Map
  
  attr_accessor :w, :h
  
  def initialize(w, h)
    @w, @h = w, h
    @tiles = Hash.new
    self.each do |x, y|
      set_cost(x, y, 0)
    end
  end
  
  def each
    for y in 0...@h
      for x in 0...@w
        yield x, y
      end
    end
  end
  
  def set_cost(x, y, cost)
    @tiles[[x, y]] = cost
  end
  
  def get_cost(x, y)
    return @tiles[[x, y]]
  end
  
  def outside?(x, y)
    return ((x < 0) or (y < 0) or (x >= @w) or (y >= @h))
  end
  
  def print
    line = ""
    each do |x, y|
      line += get_cost(x, y).to_s + " "
      if x == @w - 1
        puts line
        line = ""
      end
    end
  end
  
end