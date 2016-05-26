every 1.day, at: '5pm' do
  rake 'send_new_contacts_digest'
end

every 1.day, at: '6pm' do
  rake 'send_new_hosts_digest'
end
