class SessionsController < ApplicationController
  before_action :require_login, only: :destroy

  def new
  end

  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_create_from(auth)
    session[:user_id] = user.id
    redirect_to root_url, notice: "Logged in with #{auth['provider'].titleize}"
  end

  def destroy
    reset_session
    redirect_to login_url, notice: 'Logged out'
  end

  def failure
    redirect_to login_url, alert: 'Failed to login'
  end
end
