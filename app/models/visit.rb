class Visit < ActiveRecord::Base
  validates_date :start_date, on: :create, on_or_after: :today
  
  geocoded_by :zipcode
  after_validation :geocode
end
