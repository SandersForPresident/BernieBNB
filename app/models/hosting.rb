class Hosting < ActiveRecord::Base
  validates :zipcode, :max_guests, presence: true

  geocoded_by :zipcode
  after_validation :geocode

  belongs_to :user
end
