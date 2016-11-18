class WasteCountsController < ApplicationController
  def new
    if request.xhr?
      @waste_counts_json = params[:waste_counts]
      @waste_counts_json.each do |key, item|
        date = Time.parse(item['date']).strftime("%F")
        date = date + " " + Time.now.strftime("%T %:z")
        date = Time.parse(date)
        logger.info date
        @waste_count = WasteCount.new
        @waste_count.count = item['count']
        @waste_count.food_id = item['food_id']
        @waste_count.user_id = item['user_id']
        @waste_count.created_at = date 
        @waste_count.save 
      end
      success = { :status => "ok", :message => "Success!" } 
      render :json => success
      flash[:success] = "Counts saved!"
    end
  end

  def create
  end

  def update
  end

  def destroy
    WasteCount.find(params[:id]).destroy
    redirect_to foods_my_today_path, notice: "Count removed."
  end

  def show
  end

  def index
    @waste_counts = WasteCount.all
  end

  private 

  def waste_counts_params
    params.require(:waste_count).permit(:count, :food_id)
  end
end
