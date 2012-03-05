# Fields of Color by Erik Svedäng Mars 1, 2012

$Field_w = 25
$Field_h = 25
$Margin = 25
$Infile = "in.txt"

class Fieldsofcolor < Processing::App
  
  def setup
    background(0)
    frame_rate(4)
    no_stroke()
    load_code()
    create_fields()   
    @last_mtime = 0
    $has_error = false
  end
  
  def load_code
    $code = ""
    $file = File.open($Infile, 'r') 
    while(line = $file.gets())
      $code += line
    end
    @last_mtime = File.stat($Infile).mtime
    $has_error = false
    $file.close()
  end
  
  def create_fields
    x = y = $Margin
    @fields = []
    while(x + $Field_w <= width - $Margin)
      while(y + $Field_h <= height - $Margin)
        @fields.push(Field.new(x, y))
        y += $Field_h
      end
      x += $Field_w
      y = $Margin
    end
  end
  
  def draw
    @fields.each do | field | 
      field.generate_new_color()
      field.draw()
    end
    check_for_file_update
  end
  
  def check_for_file_update
    if File.stat($Infile).mtime != @last_mtime
      load_code()
    end
  end
  
  # Field class is inside main class to access the RP5 functions directly 
  # (could use $app instead)
  
  class Field

    def initialize(x, y)
      @x, @y = x, y
      @color = color(0)
    end

    def generate_new_color()
      unless $has_error then evaluate_code() end
    end
    
    def evaluate_code()
      r = g = b = 0
      begin
        eval($code)
      rescue Exception => e
        puts "Problem with the in file: " + e
        $has_error = true
      end
      @color = color(r, g, b)
    end

    def draw()
      fill(@color)
      rect(@x, @y, $Field_w, $Field_h)
    end

  end
  
end

Fieldsofcolor.new :title => "Fields of Color", :width => 700, :height => 700
