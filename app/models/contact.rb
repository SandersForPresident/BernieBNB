class Contact < ActiveRecord::Base
  validates :visitor_id, :host_id, presence: true
  validates_uniqueness_of :visitor_id, scope: :host_id
end
