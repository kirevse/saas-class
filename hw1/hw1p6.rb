#!/usr/bin/env ruby

# Part 6. iterators, blocks, yield
# Given two collections (of possibly different lengths), we want to get the Cartesian product of the
# sequences�in other words, every possible pair of N elements where one element is drawn from each collection.
# For example, the Cartesian product of the sequences a==[:a,:b,:c] and b==[4,5] is:
# a�b == [[:a,4],[:a,5],[:b,4],[:b,5],[:c,4],[:c,5]]
#
# Create a method that accepts two sequences and returns an iterator that will yield the
# elements of the Cartesian product, one at a time, as a two-element array.
# - It doesn't matter what order the elements are returned in. So for the above example,
#   the ordering [[:a,4], [:b,4], [:c,4], [:a,5], [:b,5], [:c,5]] would be
#   correct, as would any other ordering.
# - It does matter that within each pair, the order of the elements matches the order in
#   which the original sequences were provided. That is, [:a,4] is a member of the
#   Cartesian product a�b, but [4,:a] is not. (Although [4,:a] is a member of the
#   Cartesian product b�a.]
#
# To start you off, here is a pastebin link to skeleton code(http://pastebin.com/cgSuhtPf) showing
# possible correct results. For your convenience the code is also shown below

class CartesianProduct
    include Enumerable
 
    def initialize(array1, array2)
        @array1 = array1
        @array2 = array2
    end
    
    def each
        if block_given?
            unless @array1.length == 0 or @array2.length == 0
                @array1.each do
                    |a| @array2.each do
                        |b| yield [a, b]
                    end
                end
            end
        end            
    end
end

#Examples of use
c = CartesianProduct.new([:a,:b], [4,5])
c.each { |elt| puts elt.inspect }
# [:a, 4]
# [:a, 5]
# [:b, 4]
# [:b, 5]
c = CartesianProduct.new([:a,:b], [])
c.each { |elt| puts elt.inspect }
# (nothing printed since Cartesian product
# of anything with an empty collection is empty)