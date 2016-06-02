class Food < ActiveRecord::Base
  belongs_to :user
  validate :food_type_validation

  def food_type_validation
    errors.add(:food_type, "Must be 'completed' or 'raw'.") if food_type != ( "completed" || "raw" )
  end
end
