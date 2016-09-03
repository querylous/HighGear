class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_first


  def login_first
    unless logged_in?
      flash[:error] = "You must be logged in to access this application."
      redirect_to login_url
    end
  end
end
