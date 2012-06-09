class Movie < ActiveRecord::Base
  def self.all_ratings
    select(:rating).collect(&:rating).uniq.sort
  end
end
