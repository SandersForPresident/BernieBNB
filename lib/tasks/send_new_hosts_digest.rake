desc 'send new host digest'

task send_new_hosts_digest: :environment do
  Visit.includes(:user).all.each do |visit|
    new_host_data = Hosting.includes(:host).near(visit).where("created_at >= ?", 1.day.ago).map do |new_hosting|
      {
        hosting: new_hosting,
        host: new_hosting.host
      }
    end

    return if new_host_data.empty?

    UserMailer.new_host_digest(visit, visit.user, new_host_data).send_now
  end
end
