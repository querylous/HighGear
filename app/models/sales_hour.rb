class SalesHour < ActiveRecord::Base
  belongs_to :user
  validates :projected_sales, :actual_sales, :store_number, 
    numericality: true, allow_nil: true


  def self.caught_up?(store_number)
    updated = SalesHour.where(updated_at: (Time.now - 90.minutes)..Time.now, store_number: store_number).take(1)
    if updated.count > 0
      return true
    end
    if updated.count <= 0
      return false
    end
  end

  def self.last_updated(store_number)
    last = SalesHour.where(store_number: store_number).order(updated_at: :desc).take(1)
    return last[0].updated_at
  end

end
