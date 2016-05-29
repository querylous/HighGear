class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new 
  end

  def create
    @user = User.new(user_params)
    if @user.save
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
    redirect_to(root_url) unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit(:emp_no, :fname, :lname, 
                                 :password, :password_confirmation, :email)
  end
end
