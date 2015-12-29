require 'rails_helper'

RSpec.describe Contact, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:contact)).to be_valid
  end

  it "does not allow visitor to contact host more than once" do
    first_contact = FactoryGirl.create(:contact, visitor_id: 1, host_id: 2)
    expect { FactoryGirl.create(:contact, visitor_id: 1, host_id: 2) }
      .to raise_error
  end

  it "allows a user to contact a host who has contacted her for her hosting" do
    first_contact = FactoryGirl.create(:contact, visitor_id: 1, host_id: 2)
    expect(FactoryGirl.create(:contact, visitor_id: 2, host_id: 1))
      .to be_valid
  end
end
