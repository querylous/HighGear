class WasteCount < ActiveRecord::Base
  belongs_to :foods
  belongs_to :user


  def time_block
    breakfast = "04:00".."10:30"
    lunch = "10:31".."14:00"
    snack = "14:01".."17:00"
    dinner = "17:01".."20:00"
    late = "20:00".."23:59"
    close = "00:00".."03:00"
    curr_item_time = self.created_at.strftime("%H:%M")

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
end
