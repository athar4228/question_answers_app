class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  rescue_from ActionController::RoutingError, with: :not_found

  def not_found
    redirect_to :root
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  helper_method :user_signed_in?, :current_user
end
