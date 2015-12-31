class Contact < ActiveRecord::Base
  validates :visitor_id, :hosting_id, presence: true
  validates :visitor_id, uniqueness: { scope: :hosting_id }

  belongs_to :visitor, class_name: "User", foreign_key: :visitor_id
  belongs_to :hosting
end
