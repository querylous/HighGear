class SalesHoursController < ApplicationController

  include SalesHoursHelper


  def index
    if current_user.admin?
      store_number = params[:store] || current_user.store_number
    else
      store_number = current_user.store_number 
    end
    if params[:date].nil?
      @start_date = Time.now.beginning_of_day + 4.hours
    else
      @start_date = (Time.parse(params[:date].to_s).beginning_of_day) + 4.hours
    end
    end_date = @start_date.end_of_day + 3.hours
    if @start_date.friday? || @start_date.saturday?
      end_date = @start_date.end_of_day + 4.hours
    end
    @sales_hours = SalesHour.where(
      store_number: store_number,
      datetime: @start_date..end_date
      )
    @sales_hours = @sales_hours.sort_by &:datetime
  end
  
  def create


  end
  
  def update
#    @sales_hour = SalesHour.find(params[:id]) 
#    @sales_hour.update_attributes!(sales_hour_params)
#    @sales_hour.update_attributes!(user_id: params[:user_id])
    respond_to do |format|
    format.html {
    if request.xhr?
      @sales_hour = SalesHour.find(params[:id])
      @sales_hour.actual_vlh = params[:actual_vlh].to_f unless params[:actual_vlh].nil?
      @sales_hour.ttl = params[:ttl].to_i unless params[:ttl].nil?
      @sales_hour.actual_sales = params[:actual_sales].to_i unless params[:actual_sales].nil?
      @sales_hour.update_attributes(user_id: params[:user_id]) unless !@sales_hour.user_id.nil?
      @sales_hour.save
      success = { :status => "ok", :message => "Successfully updated" }
      render :json => success
    else
    end
    }
    end
  end
  
  def destroy


  end
  
  def upload
    if logged_in?
      file = params[:file]
      process_projections(file.tempfile, params[:store]) 
    redirect_to sales_hours_path 
    flash[:success] = "Successfully uploaded!"
    else
      flash[:danger] = "Please login first."
      redirect_to login_url
    end
  end 

  private 
  
  def sales_hour_params
    params.require(:sales_hour).permit(:datetime, :projected_sales, :actual_sales,
                                       :projected_vlh, :actual_vlh, :ttl, 
                                       :store_number, :user_id, :id)
  end
 
end
