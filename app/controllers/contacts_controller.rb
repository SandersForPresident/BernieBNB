class ContactsController < ApplicationController
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
end
