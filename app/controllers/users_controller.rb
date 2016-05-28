class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  def index
  end

  def edit
  end

private 

  def user_params
    params.require(:user).permit(:emp_no, :fname, :lname, :password, :email)
  end
end
