class SessionsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:create]

  def create
    begin
      @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
      session[:user_id] = @user.id
      redirect_to questions_path
    rescue
      session[:user_id] = nil
      redirect_to :root
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
