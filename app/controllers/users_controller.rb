class UsersController < ApplicationController
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :phone)
  end
end