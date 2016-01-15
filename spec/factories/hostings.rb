FactoryGirl.define do
  factory :hosting do |f|
    f.host_id { rand(1..5) }
    f.zipcode { 11211 }
    f.comment { Faker::Lorem.paragraph(1) }
    f.max_guests { rand(1..10) }
  end

end
