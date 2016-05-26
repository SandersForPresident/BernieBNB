class Hosting < ActiveRecord::Base
  validates :max_guests, presence: true
  validates :zipcode, zipcode: { country_code: :es }
  validates :comment, length: { maximum: 140 }

  acts_as_paranoid

  belongs_to :host, class_name: "User", foreign_key: :host_id
  has_many :contacts

  after_validation :geocode, :if => lambda{ |obj| obj.zipcode_changed? }

  geocoded_by :zipcode do |hosting, results|
    if geo = results.first
      hosting.city = geo.city
      hosting.state = geo.state
      hosting.latitude = geo.latitude
      hosting.longitude = geo.longitude
    else
      hosting.errors.add(:base, "Unknown Zip Code") unless hosting.zipcode.nil?
    end
  end

  def first_name
    host.first_name
  end

  def was_contacted_for?(visit)
    Contact.exists?(visit_id: visit.id, hosting_id: self.id)
  end
end
