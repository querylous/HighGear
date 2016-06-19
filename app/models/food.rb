class Food < ActiveRecord::Base
  belongs_to :user
  validate :food_type_validation
  monetize :price,
           :numericality => {
             :greater_than => 0,
             :less_than_or_equal_to => 1000
           }

  def food_type_validation
    errors.add(:food_type, "Must be 'completed' or 'raw'.") unless ["Completed", "Raw"].include? food_type
  end
end
