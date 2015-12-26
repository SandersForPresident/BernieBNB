class UsersController < ApplicationController
  decorates_assigned :user

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_url(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :phone)
  end
end
