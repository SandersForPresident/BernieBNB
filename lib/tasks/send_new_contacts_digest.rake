desc 'send new contacts digest'

task send_new_contacts_digest: :environment do
  Hosting.includes(:host, contacts: [{ visit: [:user] }]).all.each do |hosting|
    new_contact_data = hosting.contacts.where("created_at >= ?", 1.day.ago).map do |new_contact|
      {
        visitor: new_contact.visit.user,
        visit: new_contact.visit,
        contact: new_contact
      }
    end

    unless new_contact_data.empty?
      byebug
      UserMailer.new_contacts_digest(hosting, hosting.host, new_contact_data).deliver_now
    end
  end
end
