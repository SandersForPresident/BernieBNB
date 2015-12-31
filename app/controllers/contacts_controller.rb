class ContactsController < ApplicationController

  def create
    @contact = current_user.contacts.new(hosting_id: params[:hosting_id])
    if @contact.save
      redirect_to contact_url(@contact)
    else
      redirect_to user_url(current_user)
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
