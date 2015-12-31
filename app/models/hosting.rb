class Hosting < ActiveRecord::Base
  validates :zipcode, :max_guests, presence: true

  geocoded_by :zipcode
  after_validation :geocode
  after_save :notify_nearby_visitors

  belongs_to :host, class_name: "User", foreign_key: :host_id

  def first_name
    host.first_name
  end

  private

  def notify_nearby_visitors
    nearby_visits = Visit
      .near(self.zipcode, 25, order: "distance")
      .where("num_travelers <= ?", max_guests)

    nearby_visits.each do |visit|
      UserMailer.new_host_email(visit, self).deliver_now
    end
  end
end
