class Contact < ActiveRecord::Base
  validates :visitor_id, :hosting_id, presence: true
  validates :visitor_id, uniqueness: { scope: :hosting_id }
end
