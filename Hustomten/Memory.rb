load 'Sentencer.rb'
require 'pp'

class Memory
  
  attr_accessor :subject
  
  def initialize
    @classes = Hash.new # is-a relationships
    @components = Hash.new # has-a relationships
    @subject = ""
    @lines = []
  end
  
  def save(filename)
    file = File.new(filename, "w")
    @lines.each do |line|
      file.write("#{line}\n")
    end
  end
  
  def load(filename)
    file = File.new(filename, "r")
    file.each do |line|
      analyze(line.chomp)
    end
  end
    
  # Let the 'Memory' analyze a string. Returns a string with a message of how it went.
  def analyze(s)
    @lines.push(s)
    return if s == ""
    tokens = string_to_symbol_array(s)
    paste_subject(tokens)
    pattern = get_pattern(tokens)
    type, _ = pattern
    
    case type
    when :set_subject
      _, @subject = pattern
      "OK, lets talk about #{@subject}"

    when :what_is_question
      _, @subject = pattern
      definition = what_is?(@subject)
      if definition != :not_defined
        "#{a_or_an(@subject).capitalize} #{@subject} is #{a_or_an(definition)} #{definition}"
      else
        "I don't know"
      end
    
    when :what_has_question
      _, @subject = pattern
      components = what_has?(@subject)
      first_part = "#{a_or_an(@subject).capitalize} #{@subject} has "
      if components.size == 0
        second_part =  "nothing"
      else
        a = []
        components.each do |c|
          nr = c[:count]
          name = c[:component]
          if nr == 1
            a.push("one #{name}")
          else
            a.push("#{nr} #{pluralis(name)}")
          end
        end
        second_part = a.join(", ")
      end
      return first_part + second_part
    
    when :is_a_question
      _, @subject, object = pattern
      is?(@subject, object) ? "Yes" : "No"
    
    when :has_a_question
      _, @subject, object = pattern
      has?(@subject, object) ? "Yes" : "No"
    
    when :define_class
      _, @subject, definition = pattern
      if @subject == :noun then return "A noun must be a noun" end
      @classes[@subject] = definition
      if what_is?(definition) == :not_defined
        "OK, what is #{a_or_an(definition)} #{definition}?"
      else
        "OK"
      end
    
    when :define_component
      _, @subject, count, component = pattern
      #puts "Count: #{count}, component: #{component}"
      if @components.has_key?(@subject)
        @components[@subject].push({ :component => component, :count => count })
      else
        a = []
        a.push({ :component => component, :count => count })
        @components[@subject] = a
      end
      if what_is?(component) == :not_defined
        "OK, what is #{a_or_an(component)} #{component}?"
      else
        "OK"
      end
   
    when :dont_understand
      "I didn't understand that"
    
    else
      throw "Did not understand pattern #{pattern}"
    end
  end
  
  # Eg. "dog is animal" -> [:dog, :is, :animal]
  def string_to_symbol_array(s)
    words = s.split
    a = []
    words.each do |w|
      symbol = w.downcase.to_sym
      if !is_a_or_an?(symbol)
        a.push(symbol)
      end
    end
    return a
  end
  
  def is_a_or_an?(symbol)
    return ((symbol == :a) or (symbol == :an))
  end
  
  def paste_subject(tokens)
    return if @subject == ""
    i = tokens.index(:it)
    if i != nil
      tokens[i] = @subject
    end
  end
  
  def pluralis(word)
    if word.to_s[word.size - 1] == 's' then return word else return word.to_s + 's' end
  end
  
  def a_or_an(word)
    if "aoueiy".include?(word[0]) then "an" else "a" end
  end
  
  def what_is?(noun)
    if noun == :noun
      :noun
    elsif @classes.include?(noun)
      @classes[noun]
    else
      :not_defined
    end
  end
  
  # Returns an array with all the components that a certain noun and its super classes have
  def what_has?(noun)
    components = []
    all_classes(noun).each do |class_iterator|
      Array(@components[class_iterator]).each do |component|
        components.push(component)
      end
    end
    return components
  end
  
  # Returns an array with all classes that a certain noun is
  def all_classes(noun)
    classes = []
    c = noun
    while(c != :not_defined)
      classes.push(c)
      break if c == :noun
      c = what_is?(c)
    end
    return classes
  end
  
  def is?(subject, object)
    definition = @classes[subject]
    if definition == nil
      return false
    elsif definition == object 
      return true
    else
      is?(definition, object)
    end
  end
  
  def has?(subject, target)
    things = @components[subject]
    
    if things != nil
      things.each do |t|
        if(t[:component] == target)
          return true
        end
      end
    end
    
    definition = @classes[subject] # does the super class have it?
    if definition == nil # no super class
      false
    else 
      has?(definition, target) 
    end
  end

  def dump
    puts "Classes: #{@classes}\n Components: #{@components}\n Subject: #{@subject}"
  end
  
end

