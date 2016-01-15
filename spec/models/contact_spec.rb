require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:contact)).to be_valid
  end

  it "has a valid factory - default attributes" do
    expect(FactoryGirl.create :contact).to be_valid
  end

  it "does not allow visitor to contact host more than once" do
    FactoryGirl.create :contact, visitor_id: 1, hosting_id: 2

    expect { FactoryGirl.create :contact, visitor_id: 1, hosting_id: 2 }
      .to raise_error ActiveRecord::RecordInvalid
  end

  it "allows a user to both host and visit other users" do
    FactoryGirl.create :contact, visitor_id: 1, hosting_id: 2

    expect(FactoryGirl.create :contact, visitor_id: 2, hosting_id: 1)
      .to be_valid
  end
end
