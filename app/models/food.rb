class Food < ActiveRecord::Base
  has_many :waste_counts, :dependent => :destroy
  monetize :price,
           :numericality => {
             :greater_than => 0,
             :less_than_or_equal_to => 1000
           }
end
