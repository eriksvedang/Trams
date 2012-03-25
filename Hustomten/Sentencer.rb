# The first return value is pattern the type, the rest are specific to the pattern
def get_pattern(tokens)    
  what_pos = get_pos_of(:what, tokens)
  is_pos = get_pos_of(:is, tokens)
  has_pos = get_pos_of(:has, tokens)
  
  if what_pos == 0 && is_pos == 1
    return :what_is_question, tokens[2]
  elsif tokens.size == 1
    return :set_subject, tokens[0]
  elsif what_pos == 0 && has_pos == 1
    return :what_has_question, tokens[2]
  elsif is_pos == 0
    return :is_a_question, tokens[1], tokens[2]
  elsif has_pos == 0
    return :has_a_question, tokens[1], tokens[2]
  elsif is_pos == 1
    return :define_class, tokens[0], tokens[2]
  elsif has_pos == 1
    count = tokens[2].to_s.to_i
    if count == nil
      count = 1
    end
    return :define_component, tokens[0], count, tokens[3]
  else
    return :dont_understand
  end
end

# Where in an array of tokens does a word first occur? Returns -1 if not found.
def get_pos_of(word, tokens)
  pos = 0
  tokens.each do |w|
    if w == word then
      return pos
    else
      pos += 1
    end
  end
  return -1
end