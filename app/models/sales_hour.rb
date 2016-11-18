class SalesHour < ActiveRecord::Base
  belongs_to :user
  validates :projected_sales, :actual_sales, :store_number, :actual_vlh, 
    numericality: true


end
