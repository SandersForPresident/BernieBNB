FactoryGirl.define do
  factory :hosting do |f|
    f.user_id { rand(1..5) }
    f.zipcode { Faker::Address.zip }
    f.max_guests { rand(1..5) }
  end

end
