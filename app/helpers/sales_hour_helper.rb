module SalesHourHelper
  def process_projections
    file = './projections.csv'
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
        logger.info "#{p[:date]} " + "#{p[:hour]}"
        p[:hour].gsub!("25:00", "01:00")
        logger.info "#{p[:date]} " + "#{p[:hour]}" 
        time = "#{p[:date]} " + "#{p[:hour]}"
        time = DateTime.strptime("#{time}", '%m/%d/%Y %H:%M').to_time
        logger.info time
        time = time + 1.day
        logger.info time.localtime
      else
        time = "#{p[:date]} " + "#{p[:hour]}"
        time = DateTime.strptime("#{time}", '%m/%d/%Y %H:%M').to_time
      end
      @formatted_projections.push( { :time => time, :sales => p[:sales] })
    end 
  end
end
