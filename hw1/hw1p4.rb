#!/usr/bin/env ruby

class Dessert
  
  def initialize(name, calories)
    @name = name
    @calories = calories
  end
  
  def name
    @name 
  end
  
  def name=(name)
    @name = name
  end
  
  def calories
    @calories
  end
  
  def calories=(calories)
    @calories = calories
  end
  
  def healthy?
    @calories < 200
  end

  def delicious?
    true
  end
end

class JellyBean < Dessert
  
  def initialize(name, calories, flavor)
    super name, calories
    @flavor = flavor
  end

  def flavor
    @flavor
  end

  def flavor=(flavor)
    @flavor = flavor
  end
  
  def delicious?
    @flavor == "black licorice" ? false : super
  end
end

dessert = Dessert.new "Cookie", 100
print "Name: ", dessert.name, " healthy?: ", dessert.healthy?, " delicious?: ", dessert.delicious?, "\n"   
dessert = Dessert.new "Chocolote Cake", 300
print "Name: ", dessert.name, " healthy?: ", dessert.healthy?, " delicious?: ", dessert.delicious?, "\n" 

dessert = JellyBean.new "Cupcake", 200, "black licorice"
print "Name: ", dessert.name, " healthy?: ", dessert.healthy?, " delicious?: ", dessert.delicious?, "\n"   
dessert = JellyBean.new "Ice Cream", 100, "bubble gum"
print "Name: ", dessert.name, " healthy?: ", dessert.healthy?, " delicious?: ", dessert.delicious?, "\n"   
