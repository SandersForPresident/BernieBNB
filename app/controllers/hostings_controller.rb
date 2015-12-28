class HostingsController < ApplicationController
  def new
    @hosting ||= Hosting.new(user_id: params[:user_id])
  end

  def create
    @hosting = Hosting.new(hosting_params)
    @hosting.user_id = current_user.id

    if @hosting.save
      redirect_to user_url(current_user)
    else
      flash[:errors] = @hosting.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @hosting = hosting.find(params[:id])
  end

  private

  def hosting_params
    params
      .require(:hosting)
      .permit(:zipcode, :max_guests)
  end
end
