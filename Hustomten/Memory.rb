load 'Sentencer.rb'

class Memory
  
  def initialize
    @classes = Hash.new # is-a relationships
    @components = Hash.new # has-a relationships
  end
    
  # Let the memory analyze a string. Returns a string with a message of how it went.
  def analyze(s)
    tokens = string_to_symbol_array(s)
    pattern = get_pattern(tokens)
    type, _ = pattern
    case type
    when :what_is_question
      _, subject = pattern
      definition = what_is?(subject)
      if definition != :not_defined
        "#{a_or_an(subject).capitalize} '#{subject}' is #{a_or_an(definition)} '#{definition}'"
      else
        "I don't know"
      end
    when :is_a_question
      _, subject, object = pattern
      is?(subject, object) ? "Yes" : "No"
    when :has_a_question
      _, subject, object = pattern
      has?(subject, object) ? "Yes" : "No"
    when :define_class
      _, subject, definition = pattern
      if what_is?(definition) == :not_defined
        "First tell me what #{a_or_an(definition)} '#{definition}' is"
      else
        @classes[subject] = definition
        "OK, got it"
      end
    when :define_component
      _, subject, component = pattern
      if what_is?(component) == :not_defined
        "First tell me what #{a_or_an(component)} '#{component}' is"
      else
        @components[subject] = component
        "OK, got it"
      end
    when :dont_understand
      "I don't understand that"
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
    puts "Classes: #{@classes}"
    puts "Components: #{@components}"
  end
  
end

