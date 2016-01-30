class HostingsController < ApplicationController
  before_action :ensure_current_user_is_host, only: [:edit, :update, :destroy]

  def new
    @hosting ||= Hosting.new(host_id: params[:user_id])
  end

  def create
    @hosting = Hosting.new(hosting_params)
    @hosting.host_id = current_user.id

    if @hosting.save
      redirect_to user_url(current_user),
        notice: "Hosting created! We will email you when a nearby traveler would like to stay with you."
    else
      flash.now[:errors] = @hosting.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @hosting.update(hosting_params)
      redirect_to user_url(current_user),
        notice: "Hosting updated! We will email you when a nearby traveler would like to stay with you."
    else
      flash.now[:errors] = @hosting.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    if @hosting.destroy
      redirect_to user_url(current_user), notice: "Hosting canceled"
    else
      flash.now[:errors] = @hosting.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def hosting_params
    params
      .require(:hosting)
      .permit(:zipcode, :max_guests, :comment)
  end

  def ensure_current_user_is_host
    @hosting = Hosting.find(params[:id])
    redirect_to user_url(current_user) unless @hosting.host_id == current_user.id
  end
end
