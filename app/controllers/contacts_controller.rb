class ContactsController < ApplicationController
  skip_before_action :require_current_user, only: :create_by_email
  skip_before_action :require_complete_profile, only: :create_by_email

  def create
    set_ivars

    if @contact.save
      execute_contact_callbacks
    else
      flash.now[:errors] = @contact.errors.full_messages
      render visit_url(@visit), status: :unprocessable_entity
    end
  end

  def create_by_email
    set_ivars

    if @contact.save
      execute_contact_callbacks
    else
      flash.now[:errors] = @contact.errors.full_messages
      redirect_to visit_url(@visit), status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.permit(:hosting_id, :visit_id)
  end

  def execute_contact_callbacks
    UserMailer.contact_host_email(@visit, @hosting).deliver_now
    @hosting.increment(:contact_count).save
    redirect_to visit_url(@visit),
      notice: "Successfully contacted #{@hosting.first_name}!"
  end

  def set_ivars
    @visit = Visit.find(params[:visit_id])
    @hosting = Hosting.find(params[:hosting_id])
    @contact = Contact.new(contact_params)
  end
end
