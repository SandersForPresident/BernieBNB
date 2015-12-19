FactoryGirl.define do
  factory :visit do |f|
    f.zipcode { Faker::Address.zip }
    f.num_travelers { rand(1..5) }
    start = Faker::Date.forward(20)
    f.start_date start
    f.end_date { Faker::Date.between(start, start + 5.days) }
  end
end
