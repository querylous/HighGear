class Response < ActiveRecord::Base
  belongs_to :survey

  def self.set_users(options={})
     from_date = (Time.now - 2.hours)
     from_date = Time.parse(options[:from_date]) unless options[:from_date].nil?
     from_date = from_date.beginning_of_hour.strftime("%F %T %z")
     to_date = (Time.now - 1.hour).beginning_of_hour.strftime("%F %T %z")
     selected = Response.where(created_at: from_date..to_date)   


     selected.each do |s|
      hour = s.created_at.beginning_of_hour.in_time_zone("Pacific Time (US & Canada)").strftime("%F %T")
      sales_hour = SalesHour.find_by(datetime: hour)
      manager = sales_hour.user_id unless sales_hour.nil?

      s.user_id = manager
      s.save unless manager.nil?
     end
  end
  
  def self.avg_score(collection=nil, options={})
    from_date = Time.now - 60.minutes
    to_date = Time.now
    from_date = Time.parse(options[:from_date]) unless options[:from_date].nil?
    to_date = Time.parse(options[:to_date]) unless options[:to_date].nil?
 
    scores = []
 
    selected = collection 
    selected = Response.where(created_at: from_date..to_date) unless !collection.nil?
    if selected.nil?
      return "No responses"
    end 
    unless selected.nil? 
        selected.each do |s|
        scores << s.answers[0]['responseValue'].to_f
      end
    end
    if scores.empty? 
      "No Responses"
    else
      (scores.sum / scores.count).round(2) unless scores.empty?
    end
  end

end
