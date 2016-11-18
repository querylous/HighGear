module SalesHoursHelper
  def process_projections(file = nil, store)
    file = './projections.csv' if file.nil? 
    options = { :remove_unmapped_keys => true, 
                :key_mapping => 
              { :date => :date,
                :hour_end_time => :hour,
                :projected_sales => :sales 
    } }
    @formatted_projections = [] 
    projections = SmarterCSV.process(file, options)
    projections.each do |p|
      p[:date].gsub!("'", "")
      p[:hour].gsub!("'", "")
      if p[:hour] == "25:00"
        p[:hour].gsub!("25:00", "01:00")
        time = "#{p[:date]} " + "#{p[:hour]} -07:00"
        time = DateTime.strptime("#{time}", '%m/%d/%Y %H:%M')
        time = time + 1.day
      else
        time = "#{p[:date]} " + "#{p[:hour]} -07:00"
        time = DateTime.strptime("#{time}", '%m/%d/%Y %H:%M %Z')
        logger.info time.zone
      end
      @formatted_projections.push( { :time => time, :sales => p[:sales] })
    end 

    @formatted_projections.last(144).each do |p|
      unless SalesHour.exists?(:datetime => p[:time])
        hour = SalesHour.new
        hour.datetime = p[:time]
        hour.projected_sales = p[:sales]
        hour.store_number = store
        hour.save
      end
    end
  end
 
  def process_schedule(file = nil)
    file = './schedule.csv' if file.nil?
    options = { :remove_unmapped_keys => true, 
                :key_mapping => 
              { :date => :date,
                :hour_end_time => :hour,
                :projected_vlh => :vlh
    } }
    @formatted_schedule = [] 
    projections = SmarterCSV.process(file, options)
    projections.each do |p|
      p[:date].gsub!("'", "")
      p[:hour].gsub!("'", "")
      if p[:hour] == "25:00"
        p[:hour].gsub!("25:00", "01:00")
        time = "#{p[:date]} " + "#{p[:hour]} -07:00"
        time = DateTime.strptime(time, '%m/%d/%Y %H:%M %Z')
        time = time + 1.day
      elsif p[:hour] == "26:00"
        p[:hour].gsub!("26:00", "02:00")
        time = "#{p[:date]} " + "#{p[:hour]} -07:00"
        time = DateTime.strptime(time, '%m/%d/%Y %H:%M %Z')
        time = time + 1.day
       elsif p[:hour] == "27:00"
        p[:hour].gsub!("27:00", "03:00")
        time = "#{p[:date]} " + "#{p[:hour]} -07:00"
        time = DateTime.strptime(time, '%m/%d/%Y %H:%M %Z')
        time = time + 1.day
      else
        time = "#{p[:date]} " + "#{p[:hour]} -07:00"
        logger.info time
        time = DateTime.strptime("#{time}", '%m/%d/%Y %H:%M %Z')
      end
      @formatted_schedule.push( { :time => time, :projected_vlh => p[:vlh] })
    end 

    @formatted_schedule.last(144).each do |p|
      hour = SalesHour.find_by(datetime: p[:time])
      unless hour.nil? 
        hour.projected_vlh = p[:projected_vlh]
        hour.save
      end
    end   
  end
 
  def get_total_sales_hours(id, time, col)
    selected_hours = SalesHour.where(datetime: time) 
    selected_hours = selected_hours.where(user_id: id) unless id.nil? 
    logger.info selected_hours.sum(col)
    return selected_hours.sum(col)
  end
  
  def get_sales_up_down_today
    selected_hours = SalesHour.where(datetime: (Time.now.beginning_of_day + 3.hours)..Time.now)
    total = 0
    selected_hours.each do |s|
        total += s.actual_sales - s.projected_sales unless s.actual_sales.nil?
    end
    return total
  end
  
  def get_labor_up_down_today
    selected_hours = SalesHour.where(datetime: (Time.now.beginning_of_day + 3.hours)..Time.now)
    total = 0
    selected_hours.each do |s|
        total += s.actual_vlh - s.projected_vlh unless s.actual_vlh.nil?
    end
    return total

  end
end
