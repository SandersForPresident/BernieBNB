class SessionsController < ApplicationController
  skip_before_action :require_current_user
  skip_before_action :require_complete_profile
  before_action :deny_blacklisted_users, only: :create

  def create
    return if omniauth_email_taken?(auth)

    sign_in!(user)

    if @user.email_confirmed
      redirect_to cookies[:redirect_url] || user_url(@user),
        notice: 'Signed in!'
    else
      redirect_to edit_user_url(@user),
        notice: 'Please fill out a few more details.'
    end

  ensure
    cookies.delete(:redirect_url)
  end

  def destroy
    sign_out!
    redirect_to root_url, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, notice: 'Authentication failed, please try again.'
  end

  private

  def user
    @user ||= User.find_by_provider_and_uid(auth['provider'], auth['uid']) ||
              User.create_with_omniauth(auth)
  end

  def auth
    request.env['omniauth.auth']
  end

  def omniauth_email_taken?(auth)
    provider = auth['provider']
    alt_provider = provider == 'facebook' ? 'google_oauth2' : 'facebook'
    existing_user = User.find_by_email(auth['info']['email'])

    if existing_user && existing_user.provider != auth["provider"]
      redirect_to "/auth/#{alt_provider}"
      return true
    end

    return false
  end

  def deny_blacklisted_users
    redirect_to root_url, notice: 'Authentication failed' if user.blacklisted
  end
end
