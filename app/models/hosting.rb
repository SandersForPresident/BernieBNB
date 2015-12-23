class Hosting < ActiveRecord::Base
  validates :zipcode, :max_guests, presence: true

  geocoded_by :zipcode
  after_validation :geocode
  
  belongs_to :user

  def self.can_host(visitor)
    self
      .near(visitor.zipcode, 25)
      .where("max_guests >= ?", visitor.num_travelers)
  end
end
