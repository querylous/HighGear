class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    if current_user.gm? 
      @user = User.new 
    else
      redirect_to root_url, notice: "Sorry, you have to be a GM." 
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.update_attribute(:restaurant_id, Restaurant.find_by(store: @user.store_number).id)
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id]) 
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, 
                     notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else 
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully deleted." }
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

private 

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user) or current_user.admin?
  end

  def user_params
    params.require(:user).permit(:emp_no, :fname, :lname, :store_number,
                                 :password, :password_confirmation, :email,
                                 :restaurant_id, :gm)
  end
end
