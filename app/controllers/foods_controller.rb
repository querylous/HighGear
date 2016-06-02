class FoodsController < ApplicationController
  def new
    @food = Food.new 
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      redirect_to @food
    else
      render 'new'
    end
  end

  def update
    @food = Food.find(params[:id])
  end

  def edit
  end

  def destroy
    Food.find(params[:id])
  end

  def show
    @food = Food.find(params[:id])
  end

  def index
    @foods = Food.all
  end

  private
  
  def food_params
    params.require(:food).permit(:price, :type, :name)
  end

end
