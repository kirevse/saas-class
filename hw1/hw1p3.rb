#!/usr/bin/env ruby

def combine_anagrams(words)
  words.group_by {|w| w.downcase.split(//).sort.join}.values
end

print (combine_anagrams ["cars", "for", "potatoes", "racs", "four", "scar", "creams", "scream"]), "\n"

print (combine_anagrams ["HeLLo", "hEllO"]), "\n"
