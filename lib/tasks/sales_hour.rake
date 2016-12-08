namespace :sales_hour do
  desc "Alerts managers if the sales are not caught up."
  task caught_up: :environment do
    unless Time.now.between?(Time.now.beginning_of_day, Time.now.beginning_of_day + 8.hours)
      if (Time.now - SalesHour.last_updated(4453)) > 2.minutes 
      SalesHourAlerts.sales_hour_alerts(User.first, SalesHour.last_updated(4453).localtime).deliver
      else 
        puts "All caught up. Great job. Last updated at #{SalesHour.last_updated(4453).localtime}"
      end
    end
  end

end
