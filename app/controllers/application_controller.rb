class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :set_paper_trail_whodunnit
  helper_method :current_user, :logged_in?

  def kawaiichan; puts "🌚"; end

  private

  def current_user
    @current_user ||= User.find(session["user_id"]) if session[:user_id]
  end

  def logged_in?
    current_user ? true : false
  end

  def require_login
    redirect_to login_path, alert: "Please login" unless logged_in?
  end
end
