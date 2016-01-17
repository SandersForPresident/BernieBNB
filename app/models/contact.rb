class Contact < ActiveRecord::Base
  validates :visit_id, :hosting_id, presence: true
  validates :visit_id, uniqueness: {
    scope: :hosting_id,
    message: "Host has already been contacted for this visit."
  }

  belongs_to :visit
  belongs_to :hosting

  after_create :increment_hosting_contact_counter

  private

  def increment_hosting_contact_counter
    if Hosting.exists?(id: hosting_id)
      Hosting.find(hosting_id).increment(:contact_count).save
    end
  end
end
