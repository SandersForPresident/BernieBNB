class Hosting < ActiveRecord::Base
  validates :zipcode, :max_guests, presence: true
  validates :zipcode, zipcode: { country_code: :es }
  validates :comment, length: { maximum: 140 }

  acts_as_paranoid

  belongs_to :host, class_name: "User", foreign_key: :host_id
  has_many :contacts

  after_create :notify_nearby_visitors

  after_validation :geocode

  geocoded_by :zipcode do |hosting, results|
    if geo = results.first
      hosting.city = geo.city
      hosting.state = geo.state
      hosting.latitude = geo.latitude
      hosting.longitude = geo.longitude
    else
      hosting.errors.add(:base, "Something went wrong when geocoding. Try again.")
    end
  end

  def first_name
    host.first_name
  end

  def was_contacted_for?(visit)
    Contact.exists?(visit_id: visit.id, hosting_id: self.id)
  end

  private

  def notify_nearby_visitors
    nearby_visits = Visit
      .near(self, 75, order: "distance")
      .where("num_travelers <= ?", max_guests)
      .where("start_date >= ?", Time.zone.today)

    # :nocov:
    if Rails.env.production? or  Rails.env.staging?
      nearby_visits = nearby_visits.where("user_id != (?)", self.host_id)
    end
    # :nocov:

    nearby_visits.each do |visit|
      UserMailer.new_host_email(visit, self).deliver_now
    end
  end
end
