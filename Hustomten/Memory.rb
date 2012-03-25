load 'Sentencer.rb'
require 'pp'

class Memory
  
  attr_accessor :subject
  
  def initialize
    @classes = Hash.new # is-a relationships
    @components = Hash.new # has-a relationships
    @subject = ""
  end
    
  # Let the 'Memory' analyze a string. Returns a string with a message of how it went.
  def analyze(s)
    tokens = string_to_symbol_array(s)
    paste_subject(tokens)
    pattern = get_pattern(tokens)
    type, _ = pattern
    
    case type
    when :set_subject
      _, @subject = pattern
      
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
          a.push("#{c[:count]} #{c[:component]}")
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
      puts "Count: #{count}, component: #{component}"
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
      a.push(w.downcase.to_sym)
    end
    return a
  end
  
  def paste_subject(tokens)
    return if @subject == ""
    i = tokens.index(:it)
    if i != nil
      tokens[i] = @subject
    end
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
    if Array(things).include?(target)
      return true
    else
      definition = @classes[subject] # does the super class have it?
      if definition == nil
        false
      else 
        has?(definition, target) 
      end
    end
  end

  def dump
    puts "Classes: #{@classes}\n Components: #{@components}\n Subject: #{@subject}"
  end
  
end

