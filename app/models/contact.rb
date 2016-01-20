class Contact < ActiveRecord::Base
  validates :visit_id, :hosting_id, presence: true
  validates :visit_id, uniqueness: {
    scope: :hosting_id,
    message: "Host has already been contacted for this visit."
  }

  belongs_to :visit
  belongs_to :hosting
end
