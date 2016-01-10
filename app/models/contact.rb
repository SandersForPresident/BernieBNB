class Contact < ActiveRecord::Base
  validates :visitor_id, :hosting_id, presence: true
  validates :visitor_id, uniqueness: { scope: :hosting_id }

  belongs_to :visitor, class_name: "User", foreign_key: :visitor_id
  belongs_to :hosting

  after_create :increment_hosting_contact_counter

  private

  def increment_hosting_contact_counter
    if Hosting.exists?(id: hosting_id)
      Hosting.find(hosting_id).increment(:contact_count).save
    end
  end
end
