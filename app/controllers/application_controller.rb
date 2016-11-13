class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_first

  $current_manager = nil

  def login_first(return_point = request.url)
    unless logged_in?
      set_return_point(return_point, true)
      flash[:error] = "Please login first."
      redirect_to login_url
    end
  end
 
  def return_point
    session[:return_point] || root_url
  end

  def set_return_point(path, overwrite = false)
    if overwrite or session[:return_point].blank?
      session[:return_point] = path
      logger.info "from set_return_point method: #{path}"
    end
  end

  def current_manager
    $current_manager = current_user
    flash[:success] = "You're in charge, #{current_user.fname}"
    redirect_to root_path
  end
end
