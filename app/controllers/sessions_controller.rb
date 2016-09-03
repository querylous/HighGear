class SessionsController < ApplicationController
  skip_before_action :login_first


  def new
    render 'new'
  end
  
  def create
    user = User.find_by(emp_no: params[:session][:emp_no].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to '/'
    else
      flash.now[:danger] = 'Invalid employee number/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
