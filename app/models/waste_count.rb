class WasteCount < ActiveRecord::Base
  belongs_to :foods
  belongs_to :user

  @tz = "Pacific Time (US & Canada)"
  @today = Time.now.in_time_zone(@tz)
  @last_month = (@today - 30.days)..@today
  
  def self.dollars_by_time_block(period, range=@last_month)
    selection = self.by_time_block(period, range)
    total = 0
    selection.each do |s|
      total += Food.find(s.food_id).price * s.count
    end
    return total
  end

  def self.by_time_block(period, range=@last_month)
    counts = WasteCount.where(created_at: range)
    selection = []
    counts.each do |c|
      selection << c unless c.time_block != period
    end
    return selection
  end

  def time_block
    breakfast = "04:00".."10:30"
    lunch = "10:31".."14:00"
    snack = "14:01".."17:00"
    dinner = "17:01".."20:00"
    late = "20:00".."23:59"
    close = "00:00".."03:00"
    curr_item_time = self.created_at.in_time_zone(@tz).strftime("%H:%M")

    if breakfast.cover?(curr_item_time) 
      return "Breakfast"
    end
    if lunch.cover?(curr_item_time) 
      return "Lunch"
    end
    if snack.cover?(curr_item_time) 
      return "Snack"
    end
    if dinner.cover?(curr_item_time) 
      return "Dinner"
    end
    if late.cover?(curr_item_time) 
      return "Late"
    end
    if close.cover?(curr_item_time) 
      return "Close"
    end

    return curr_item_time 
  end
  
  def breakfast?
    self.time_block == "Breakfast"
  end

  def lunch?
    self.time_block == "Lunch"
  end

  def snack?
    self.time_block == "Snack"
  end

  def dinner?
    self.time_block == "Dinner"
  end

  def late?
    self.time_block == "Late"
  end

  def close?
    self.time_block == "Close"
  end

  def cost
    price = Food.find(food_id).price
    price * count
  end
end
