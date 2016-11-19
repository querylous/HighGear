class SalesHour < ActiveRecord::Base
  belongs_to :user
  validates :projected_sales, :actual_sales, :store_number, 
    numericality: true, allow_nil: true


end
