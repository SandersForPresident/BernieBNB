class Hosting < ActiveRecord::Base
  validates :zipcode, :max_guests, presence: true

  geocoded_by :zipcode
  after_validation :geocode

  belongs_to :user

  def first_name
    self.user.first_name
  end
end
