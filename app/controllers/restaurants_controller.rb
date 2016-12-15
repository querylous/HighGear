class RestaurantsController < ApplicationController
  before_action :admin_only 
  
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant updated.'  
    end
  end

  private
  
  def restaurant_params
    params.require(:restaurant).permit(:store, :name, :gm)
  end

  def admin_only
    redirect_to root_url, notice: "Sorry, must be an admin" unless is_admin?(current_user)
  end
end
