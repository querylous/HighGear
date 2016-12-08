namespace :sales_hour do
  desc "Alerts managers if the sales are not caught up."
  task caught_up: :environment do
    unless Time.now.between?(Time.now.beginning_of_day, Time.now.beginning_of_day + 8.hours)

    Restaurant.all.each do |r|
      if (Time.now - SalesHour.last_updated(r.store)) > 90.minutes 
      SalesHourAlerts.sales_hour_alerts(r.gm, SalesHour.last_updated(r.store).localtime).deliver
      else 
        puts "All caught up. Great job. Last updated at #{SalesHour.last_updated(r.store).localtime}"
      end
    end
    end
  end

end
