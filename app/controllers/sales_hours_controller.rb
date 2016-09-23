class SalesHoursController < ApplicationController
  def index
    if params[:date].nil?
      @start_date = Time.now.beginning_of_day + 4.hours
      logger.info "date is #{@start_date}"
    else
      @start_date = (Time.parse(params[:date].to_s).beginning_of_day) + 4.hours
      logger.info "date is #{@start_date}"
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
    @sales_hour = SalesHour.find(params[:id]) 
    @sales_hour.update_attributes!(sales_hour_params)
    @sales_hour.update_attributes!(user_id: params[:user_id])
    respond_to do |format|
    format.html {
    if request.xhr?
      render :text => params[:sales_hour].values.first
    else
    end
    }
    end
  end
  
  def destroy


  end
  
  
  private 
  
  def sales_hour_params
    params.require(:sales_hour).permit(:datetime, :projected_sales, :actual_sales,
                                       :projected_vlh, :actual_vlh, :ttl, 
                                       :store_number, :user_id, :id)
end
 
end
