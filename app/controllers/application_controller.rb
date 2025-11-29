class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :require_login
  helper_method :current_user, :logged_in?

  private
  
  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_login
    return if logged_in?
    
    redirect_to login_path, alert: "ログインしてください"
  end
end
