class SessionsController < ApplicationController
  skip_before_action :require_current_user
  skip_before_action :require_complete_profile

  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
            User.create_with_omniauth(auth)
    sign_in!(@user)

    if @user.first_name && @user.phone
      redirect_to user_url(@user),
        notice: "Signed in!"
    else
      redirect_to edit_user_url(@user),
        notice: "Please fill out a few more details"
    end
  end

  def destroy
    sign_out!
    redirect_to root_url, :notice => "Signed out!"
  end
end
