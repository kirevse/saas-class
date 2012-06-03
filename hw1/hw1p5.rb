#!/usr/bin/env ruby

# Part 5: advanced OOP,metaprogramming, open classes and duck typing
# (Exercise 3.4 from ELLS)
# In lecture we saw how attr_accessor uses metaprogramming to create getters and setters
# for object attributes on the fly.
# Define a method attr_accessor_with_history that provides the same functionality as attr_accessor
# but also tracks every value the attribute has ever had:
#
#   class Foo
#     attr_accessor_with_history :bar
#   end
#   f = Foo.new # => #<Foo:0x127e678>
#   f.bar = 3 # => 3
#   f.bar = :wowzo # => :wowzo
#   f.bar = 'boo!' # => 'boo!'
#   f.bar_history # => [nil, 3, :wowzo, 'boo!']
#
# We'll start you off. Here are some hints and things to notice to get you started:
# 1.  The first thing to notice is that if we define attr_accessor_with_history in class
#     Class, we can use it as in the snippet above. This is because, as ELLS mentions, in
#     Ruby a class is simply an object of class Class. (If that makes your brain hurt, just
#     don't worry about it for now. It'll come.)
# 2.  The second thing to notice is that Ruby provides a method class_eval that takes a
#     string and evaluates it in the context of the current class, that is, the class from which
#     you're calling attr_accessor_with_history. This string will need to contain
#     a method definition that implements a setter-with-history for the desired attribute attr_name.
#
# - Don't forget that the very first time the attribute receives a value, its history array will have to be initialized.
# - Don't forget that instance variables are referred to as @bar within getters and setters, as Section 3.4 of ELLS explains.
# - Although the existing attr_accessor can handle multiple arguments (e.g.
#   attr_accessor :foo, :bar), your version just needs to handle a single argument.
#   However, it should be able to track multiple instance variables per class, with any legal
#   class names or variable names, so it should work if used this way:
  
#   class SomeOtherClass
#     attr_accessor_with_history :foo
#     attr_accessor_with_history :bar
#   end
#
# - History of instance variables should be maintained separately for each object instance. that is, if you do
#   f = Foo.new
#   f.bar = 1
#   f.bar = 2
#   f = Foo.new
#   f.bar = 4
#   f.bar_history
# then the last line should just return [nil,4], rather than [nil,1,2,4]
# Here is the skeleton to get you started:

class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s # make sure it's a string
    attr_reader attr_name # create the attribute's getter
    attr_reader attr_name + "_history" # create bar_history getter
    class_eval %Q{
      def #{attr_name}
        @#{attr_name}
      end
      
      def #{attr_name}=(#{attr_name})
        @#{attr_name}_history ||= [@#{attr_name}]
        @#{attr_name}_history.push #{attr_name}
        @#{attr_name} = #{attr_name}
      end
    }
  end
end

class Foo
  attr_accessor_with_history :bar
end

f = Foo.new # => #<Foo:0x127e678>
f.bar = 3 # => 3
f.bar = :wowzo # => :wowzo
f.bar = 'boo!' # => 'boo!'
print "#{f.bar_history}\n" # => [nil, 3, :wowzo, 'boo!']

f = Foo.new
f.bar = 1
f.bar = 2
print "#{f.bar_history}\n" # => if your code works, should be [nil,1,2]

f = Foo.new
f.bar = 4
print "#{f.bar_history}\n" # => if your code works, should be [nil,4]

class SomeOtherClass
  attr_accessor_with_history :foo
  attr_accessor_with_history :bar
end

f = SomeOtherClass.new
f.foo = 1
f.foo = 2
f.bar = 3
f.bar = 4

print "#{f.foo_history}\n#{f.bar_history}\n" # => if your code works, should be [nil,1,2]

# a) [ELLS ex. 3.11] Extend the currency-conversion example from lecture so that you can write
# 5.dollars.in(:euros)
# 10.euros.in(:rupees)
# etc.
# - You should support the currencies 'dollars', 'euros', 'rupees' , 'yen' where the
# conversions are: rupees to dollars, multiply by 0.019; yen to dollars, multiply by 0.013;
# euro to dollars, multiply by 1.292.
# - Both the singular and plural forms of each currency should be acceptable, e.g.
# 1.dollar.in(:rupees) and 10.rupees.in(:euro) should work.
# You can use the code shown in lecture as a starting point if you wish; it is shown below and is
# also available at pastebin http://pastebin.com/agjb5qBF

class Numeric
  @@currencies = {'dollar' => 1.000, 'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}

  def in(currency)
    singular_currency = currency.to_s.gsub(/s$/, '')
    if @@currencies.has_key? singular_currency
      self / @@currencies[singular_currency]
    else
      super
    end
  end
  
  def method_missing(method_id, *args)
    name = method_id.to_s
    singular_currency = name.gsub(/s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end
end

print "#{5.dollars.in(:euros)}\n"
print "#{10.euros.in(:rupees)}\n"
print "#{1.dollar.in(:rupees)}\n"
print "#{10.rupees.in(:euro)}\n"
print "#{5.rupees.in(:yen)}\n"

# b) Adapt your solution from the "palindromes" question so that instead of writing palindrome?
# ("foo") you can write "foo".palindrome? HINT: this should require fewer than 5 lines
# of code.
class String
  def palindrome?
    str = gsub(/\W+|_+/, "").downcase
    str == str.reverse
  end
end

print "A man, a plan, a canal -- Panama".palindrome?, "\n" #=> true
print "Madam, I'm Adam!".palindrome?, "\n" # => true
print "Abracadabra".palindrome?, "\n" # => false (nil is also ok)

# c) Adapt your palindrome solution so that it works on Enumerables. That is:
# [1,2,3,2,1].palindrome? # => true
# (It's not necessary for the collection's elements to be palindromes themselves--only that the
# top-level collection be a palindrome.) HINT: this should require fewer than 5 lines of code.
# Although hashes are considered Enumerables, your solution does not need to make sense for
# hashes (though it should not error).
module Enumerable
  def palindrome?
    array = to_a
    array == array.reverse
  end
end

print [1,2,3,2,1].palindrome?, "\n" #=> true
print [1,2,3,4,5].palindrome?, "\n" # => false
print ({"hello" => "world"}.palindrome?), "\n"
print (1..2).palindrome?, "\n"
