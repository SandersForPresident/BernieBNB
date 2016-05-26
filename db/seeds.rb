# To seed your development db, run `bundle exec rake db:reset`
# This will create some Visits and Hostings in various regions with some randomness.
# Some current limitations:
# * Currently, no examples of the Contact model (however, randomized contact counts on the Hostings)
# * Sleep between creating Visits and Hostings to avoid overloading geocoding API calls
# * Timestamps are not accounted for (all will be when you seeded the db)

SAMPLE_RATE = 0.3
zips = CSV.read(Rails.root.join('db', 'csv', 'us_postal_codes.csv')).drop(1)

500.times do
  FactoryGirl.create(:user, phone: "555-555-5555")
end

2.times do
  User.last(200).each do |user|
    location = zips.sample

    if rand > SAMPLE_RATE
      start_date = Time.zone.now + rand(20)

      Visit.new(
        user_id: user.id,
        start_date: start_date,
        end_date: start_date + rand(7),
        zipcode: location[0],
        city: location[1],
        state: location[3],
        latitude: location[5],
        longitude: location[6]
      ).save(validate: false)
    else
      Hosting.new(
        host_id: user.id,
        zipcode: location[0],
        city: location[1],
        state: location[3],
        latitude: location[5],
        longitude: location[6]
      ).save(validate: false)
    end
  end
end
