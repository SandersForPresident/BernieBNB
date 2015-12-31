class UsersController < ApplicationController
  skip_before_action :require_complete_profile, only: [:edit, :update]
  decorates_assigned :user

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_url(current_user) if @user.id != current_user.id
  end

  def update
    @user = current_user

    if @user.update(user_params)

      if @user.email_confirmed
        redirect_to user_url(@user),
          notice: "Account updated"
      else
        UserMailer.registration_confirmation(@user).deliver_now
        redirect_to root_url,
          notice: "Email confirmation sent, check your email for instructions"
      end

    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_url(@user)
    end
  end

  def confirm_email
    @user = User.find_by_confirm_token(params[:id])

    if @user
      @user.email_activate
      sign_in!(@user)

      UserMailer.welcome_email(@user).deliver_now

      redirect_to user_url(@user)
    else
      flash[:error] = "Sorry, could not confirm user"
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :phone, :email)
  end
end
