FactoryGirl.define do
  factory :visit do |f|
    f.user_id { rand(1..5) }
    f.zipcode { "11211" }
    f.num_travelers { rand(1..5) }
    start = Faker::Date.forward(20)
    f.start_date start
    f.end_date { Faker::Date.between(start, start + 5.days) }
  end
end
