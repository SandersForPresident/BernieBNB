class ContactsController < ApplicationController

  def create
    @contact = current_user.contacts.new(hosting_id: params[:hosting_id])
    visit = Visit.find(params[:visit_id])
    hosting = Hosting.find(params[:hosting_id])

    if @contact.save
      UserMailer.contact_host_email(visit, hosting).deliver_now
      redirect_to visit_url(visit),
        notice: "Successfully contacted #{hosting.first_name}!"
    else
      flash[:errors] = ["Could not contact #{hosting.first_name}"]
      redirect_to visit_url(visit), status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    destroy_permission? && @contact.destroy
    redirect_to user_url(current_user)
  end

  private

    def destroy_permission?
      current_user &&
        (@contact.hosting_id == current_user.id || @contact.visitor_id == current_user.id)
    end
end
