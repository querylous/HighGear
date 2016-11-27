module FoodsControllerHelper
  def weekly_dollars_by_user
    weekly_user_dollars = [] 
    users = User.all
    users.each do |curr_user|
      weekly_user_dollars << { curr_user.id => get_total_dollars(curr_user.id, 
        (Time.now - 7.days)..Time.now) }
    end
    weekly_user_dollars.sort_by! { |y| y.values }
    return weekly_user_dollars
  end

  def get_total_dollars(id, time)
    total_dollar_cost = []
    if id != "any"
      user = User.find_by_id(id)
      selected_waste_counts = user.waste_counts.where(created_at: time)
    else
      selected_waste_counts = WasteCount.where(created_at: time) 
    end
    unique_food_ids = selected_waste_counts.uniq.pluck(:food_id)
    unique_food_ids.each do |u|
      count = selected_waste_counts.where(food_id: u).sum('count')
      cost_per_item = Food.find_by_id(u).price
      total_dollar_cost << count * cost_per_item  
    end 
    return total_dollar_cost.sum 
  end

  def yesterday_top_waste_dollars
    time = ((Time.now - 1.day).beginning_of_day + 4.hours)..((Time.now - 1.day).end_of_day + 1.hours)
    top_yesterday_waste = []
    selected_waste_counts = WasteCount.where(created_at: time)
    unique_food_ids = selected_waste_counts.uniq.pluck(:food_id)
    unique_food_ids.each do |u|
      count = selected_waste_counts.where(food_id: u).sum('count')
      cost_per_item = Food.find_by_id(u).price
      top_yesterday_waste << { u => count * cost_per_item }
    end 
    top_yesterday_waste.sort_by! { |y| y.values }
    return top_yesterday_waste.reverse[0..9]
  end
  
  def last_count_time
    if WasteCount.last.nil?
      return "Never!"
    else
      time = WasteCount.last.created_at unless WasteCount.last.nil?
      time = time.in_time_zone("Pacific Time (US & Canada)")
      return time.to_s(:time)
    end
  end

end
