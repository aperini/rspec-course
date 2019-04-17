# handy methods for debugging
def debug_groups(groups)
  puts "
      cards grouped by their suit:
      "
  puts groups.to_s
end

def debug_array(array)
  puts "
    evaluating array:"
  p array
end

def debug_first_pair(first_pair)
  p('first non-contiguous pair: ' + first_pair.to_s) if first_pair
  first_pair
end
