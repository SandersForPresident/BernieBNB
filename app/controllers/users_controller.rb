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
    new_account = @user.first_name.nil? # Won't send welcome email without first name

    if @user.update(user_params)
      UserMailer.welcome_email(@user).deliver_now if new_account
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_url(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :phone, :email)
  end
end
