class FoodsController < ApplicationController


  def letsencrypt
    render text: "Z9nV85V5M4y0BKCV3Lg00t-t-WEfohLwq58Xe9Eq2-Q.QbRnnbYoBYeb68-0aNKckB_eAAFSPy1bOEpq7ASSaoU"
  end

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
    @food.sort_order = 0
    if @food.save
      redirect_to foods_url 
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
             redirect_to foods_url, notice: 'Food item Successfully updated.' 
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
    @foods = Food.all
    if params[:created_date].nil?
      @selected_counts = WasteCount
        .where(created_at: (Time.parse("04:00"))..(Time.now.end_of_day + 3.hours))
      @date = Time.now
    else
      @date = Time.parse(params[:created_date].to_s) 
      @selected_counts = WasteCount
        .where(created_at: (@date.beginning_of_day + 4.hours)..(@date.end_of_day + 3.hours))
    end
    @week_counts = WasteCount
      .where(created_at: (Time.now - 7.days)..Time.now)
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


  def sort
    if request.xhr?  
      @food = Food.find(params[:id])
      @food.sort_order = params[:sort_order]
      @food.save
      success = { :status => "ok", :message => "Success!" }
      render :json => success  
    end
  end

  def search
    if params[:start_date][0].blank? || params[:end_date][0].blank?
      redirect_to foods_path
      flash[:error] = "We needs both dates entered, please."
    else
      start_date = Time.parse(params[:start_date].to_s)
      end_date = Time.parse(params[:end_date].to_s)
      user_id = params[:user_id][0].to_i
      if user_id != 0 
        @results = WasteCount.where(created_at: start_date..end_date, user_id: user_id)
      else
        @results = WasteCount.where(created_at: start_date..end_date)
      end
      unless @results.blank?
        respond_to do |format|
          format.html { return @results }
          format.json { render json: @results }
        end
      else
      redirect_to foods_path
      flash[:notice] = "No counts between the selected time frame." 
      end
    end
  end

  def upload
    if logged_in?
      file = params[:file]
      options = {}
      n = SmarterCSV.process(file.tempfile, options) do |array|
        # we're passing a block in, to process each resulting hash / =row (the block takes array of hashes)
        #       # when chunking is not enabled, there is only one hash in each array
        Food.create( array.first )
      end
    redirect_to foods_path
    flash[:success] = "Successfully uploaded!"
    else
      flash[:danger] = "Please login first."
      redirect_to login_url
    end
  end

  def my_today 
    @my_today = WasteCount
      .where(created_at: (Time.now.midnight + 3.hours)..Time.now, 
             user_id: current_user.id)
      .order(food_id: :asc)
    if @my_today.blank?
      redirect_to foods_path, notice: "How about you count waste first?"
    end
  end

  private
  
  def food_params
    params.require(:food).permit(:price, :type, :name, 
                                 :food_type, :wrin, :user_id, :sort_order)
  end

end
