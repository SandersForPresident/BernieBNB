desc 'send new contacts digest'

task send_new_contacts_digest: :environment do
  Hosting.includes(:host, contacts: [{ visit: [:user] }]).all.each do |hosting|
    new_contact_data = hosting.contacts.where("created_at >= ?", 1.day.ago).map do |new_contact|
      next unless new_contact.visit

      {
        visitor: new_contact.visit.user,
        visit: new_contact.visit,
        contact: new_contact
      }
    end

    new_contact_data.reject! { |cd| cd.nil? }
    next if new_contact_data.empty?

    UserMailer.new_contacts_digest(hosting, hosting.host, new_contact_data).deliver_now
  end
end
