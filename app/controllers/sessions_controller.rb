class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if @user
      session[:user_id] = @user.id
      redirect_to user_url(@user), :notice => "Signed in!"
    else
      @user = User.create_with_omniauth(auth)
      session[:user_id] = @user.id
      redirect_to edit_user_url(@user), :notice => "Almost there..."
    end
  end

def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
