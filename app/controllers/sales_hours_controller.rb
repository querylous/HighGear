class SalesHoursController < ApplicationController
  def index
    if params[:date].nil?
      @start_date = Time.now.beginning_of_day + 4.hours
    else
      @start_date = (Time.parse(params[:date].to_s).beginning_of_day) + 4.hours
    end
    end_date = @start_date.end_of_day + 3.hours
    @sales_hours = SalesHour.where(
      store_number: current_user.store_number,
      datetime: @start_date..end_date
      )
  end
  
  def create


  end
  
  def update


  end
  
  def destroy


  end
  
end
