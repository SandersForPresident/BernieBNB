FactoryGirl.define do
  factory :user do |f|
    f.uid { SecureRandom.urlsafe_base64(17) }
    f.email { Faker::Internet.email }
    f.first_name { Faker::Name.first_name }
    f.phone { Faker::PhoneNumber.cell_phone }
  end
end
