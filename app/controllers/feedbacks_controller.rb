class FeedbacksController < ApplicationController

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.valid?
      FeedbackMailer.new_feedback(@feedback).deliver_now
      redirect_to contact_path, notice: "Your feedback has been sent."
    else
      flash[:error] = "An error occurred while delivering this feedback."
      render :new
    end
  end

private
  def feedback_params
    params.require(:feedback).permit(:name, :email, :content)
  end
end
