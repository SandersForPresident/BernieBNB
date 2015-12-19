class Visit < ActiveRecord::Base
  geocoded_by :zipcode
  after_validation :geocode
end
