class ContactsController < ApplicationController
  skip_before_action :require_current_user, only: :create_by_email
  skip_before_action :require_complete_profile, only: :create_by_email

  def create
    visit = Visit.find(params[:visit_id])
    hosting = Hosting.find(params[:hosting_id])
    @contact = visit.contacts.new(hosting_id: hosting.id)

    if @contact.save
      UserMailer.contact_host_email(visit, hosting).deliver_now
      hosting.increment(:contact_count).save
      redirect_to visit_url(visit),
        notice: "Successfully contacted #{hosting.first_name}!"
    else
      flash[:errors] = ["Could not contact #{hosting.first_name}"]
      redirect_to visit_url(visit), status: :unprocessable_entity
    end
  end

  def create_by_email
    visit = Visit.find(params[:visit_id])
    hosting = Hosting.find(params[:hosting_id])
    @contact = visit.contacts.new(hosting_id: hosting.id)

    if @contact.save
      UserMailer.contact_host_email(visit, hosting).deliver_now
      hosting.increment(:contact_count).save
      redirect_to visit_url(visit),
        notice: "Successfully contacted #{hosting.first_name}!"
    else
      flash[:errors] = ["Could not contact #{hosting.first_name}"]
      redirect_to visit_url(visit), status: :unprocessable_entity
    end
  end
end
