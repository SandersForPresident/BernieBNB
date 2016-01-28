# To seed your development db, run `bundle exec rake db:reset`
# This will create some Visits and Hostings in various regions with some randomness.
# Some current limitations:
# * Currently, no examples of the Contact model (however, randomized contact counts on the Hostings)
# * Sleep between creating Visits and Hostings to avoid overloading geocoding API calls
# * Timestamps are not accounted for (all will be when you seeded the db)
#
# 15 zips in Missouri
mo_zips = %w|65899 65806 65786 65714 65646 65215 65211 65202 65201 64155 64164 64171 63150 63105 63130|
mo_zips.shuffle!
# 10 zips in Georgia
ga_zips = %w|30007 30043 30046 30396 30390 30380 30370 31408 31414 31416|
ga_zips.shuffle!

# 15 zips in various states
random_zips =%w|11211 90210 10003 80294 80301 80307 66609 66692 66110 66101 60639 60643 60677 61378 61801|
random_zips.shuffle!

40.times do
  FactoryGirl.create(:user, phone: "555-555-5555")
end

# counter to create a visit or hosting for each user
counter = 1

[mo_zips, ga_zips, random_zips].each do |location|
  (location.length / 3).times do
    FactoryGirl.create(:hosting, host_id: counter, contact_count: rand(5), zipcode: location.pop)
    counter += 1
    sleep(0.33)
  end

  until location.empty? do
    FactoryGirl.create(:visit, user_id: counter, zipcode: location.pop)
    counter += 1
    sleep(0.33)
  end
end
