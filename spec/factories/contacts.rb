FactoryGirl.define do
  factory :contact do |f|
    f.hosting_id { rand(1..5) }
    f.visitor_id { rand(1..5) }
  end

end
