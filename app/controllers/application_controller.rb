class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_first

  $current_manager = nil

  def login_first
    unless logged_in?
      flash[:error] = "You must be logged in to access this application."
      redirect_to login_url
    end
  end
  
  def current_manager
    $current_manager = current_user
    flash[:success] = "You're in charge, #{current_user.fname}"
    redirect_to root_path
  end
end
