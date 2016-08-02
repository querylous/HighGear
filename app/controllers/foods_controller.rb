class FoodsController < ApplicationController
  def new
    if logged_in?
      @food = Food.new 
    else
      flash[:danger] = "Please login first."
      redirect_to login_url 
    end
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id
    
    if @food.save
      redirect_to @food
    else
      render 'new'
    end
  end

  def update
    @food = Food.find(params[:id])
    respond_to do |format|
      if @food.update_attributes(food_params)
        format.html { 
          if request.xhr?
             render :text => params[:food].values.first
          else
             redirect_to @food, notice: 'Food item Successfully updated.' 
          end
        }
      end
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def destroy
    Food.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to foods_url, 
                    notice: "Food successfullly removed." }
    end
  end

  def show
    @food = Food.find(params[:id])
  end

  def index
    @today_counts = WasteCount
      .where(created_at: Time.now.midnight..Time.now)
    @foods = Food.all
    @breakfast_completed = @foods
      .where(["food_type = ?", "Breakfast Completed"])
      .order("sort_order")
    @breakfast_raw = @foods
      .where(["food_type = ?", "Breakfast Raw"])
      .order("sort_order")
    @lunch_raw = @foods
      .where(["food_type = ?", "Lunch Raw"])
      .order("sort_order")
    @lunch_completed = @foods
      .where(["food_type = ?", "Lunch Completed"])
      .order("sort_order")
  end

  def today_counts
    @today_counts = WasteCount
      .where(created_at: Time.now.midnight..Time.now)
  end

  def sort
    if request.xhr?  
      @food = Food.find(params[:id])
      @food.sort_order = params[:sort_order]
      @food.save
      success = { :status => "ok", :message => "Success!" }
      render :json => success  
    end
  end

  private
  
  def food_params
    params.require(:food).permit(:price, :type, :name, 
                                 :food_type, :wrin, :user_id)
  end

end
