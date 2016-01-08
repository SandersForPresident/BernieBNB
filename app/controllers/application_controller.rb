class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_current_user
  before_action :require_complete_profile
  before_action :set_locale
 
  helper_method :current_user

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def sign_in!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def sign_out!
    current_user.try(:reset_session_token)
    session[:session_token] = nil
  end

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def require_current_user
    if current_user.nil?
      redirect_to root_url
    elsif params[:user_id] && current_user.id != params[:user_id].to_i
      redirect_to user_url(current_user)
    end
  end

  def require_complete_profile
    unless current_user.phone && current_user.first_name && current_user.email_confirmed
      redirect_to edit_user_url(current_user)
    end
  end
end
