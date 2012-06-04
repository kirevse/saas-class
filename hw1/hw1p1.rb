#!/usr/bin/env ruby

def palindrome?(string)
  str1 = string.gsub(%r{\W+|_+}, '').downcase
  str1 == str1.reverse
end

print palindrome?("A man, a plan, a canal -- Panama"), "\n"
print palindrome?("Madam, I'm Adam!"), "\n"
print palindrome?("Abracadabra"), "\n"

def count_words(string)
  h = Hash.new 0
  string.downcase.split(%r{\W+|_+}).each {|s| h[s] = h[s] + 1}
  h
end

print count_words("A man, a plan, a canal -- Panama"), "\n"
print count_words("Doo bee doo bee doo"), "\n"