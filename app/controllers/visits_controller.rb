class VisitsController < ApplicationController
  def new
    @visit ||= Visit.new(user_id: params[:user_id])
  end

  def create
    @visit = Visit.new(visit_params)
    @visit.user_id = current_user.id

    if @visit.save
      redirect_to visit_url(@visit)
    else
      flash[:errors] = @visit.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @visit = Visit.find(params[:id])
  end

  private

  def visit_params
    params
      .require(:visit)
      .permit(:zipcode, :num_travelers, :start_date, :end_date)
  end
end
