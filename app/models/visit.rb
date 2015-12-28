class Visit < ActiveRecord::Base
  validates_date :start_date, on: :create, on_or_after: :today
  validates_date :end_date, on: :create, on_or_after: :start_date

  belongs_to :user

  geocoded_by :zipcode
  after_validation :geocode

  def available_hosts
    Hosting
      .near(self.zipcode, 25, order: "distance")
      .where("max_guests >= ?", num_travelers)
  end
end
