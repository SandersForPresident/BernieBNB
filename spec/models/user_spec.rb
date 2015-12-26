require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is not valid without a Uid" do
    expect { FactoryGirl.create(:user, uid: nil) }.to raise_error ActiveRecord::RecordInvalid
  end

  it "is not valid without an email" do
    expect { FactoryGirl.create(:user, email: nil) }.to raise_error ActiveRecord::RecordInvalid
  end

  it "allows no first name, but if present, can't be blank" do
    expect(FactoryGirl.create(:user, first_name: nil)).to be_valid
    expect { FactoryGirl.create(:user, first_name: "") }.to raise_error ActiveRecord::RecordInvalid
  end

  it "allows no phone number, but if present, can't be blank" do
    expect(User.create(uid: SecureRandom.urlsafe_base64(17), email: "test@fakemail.com"))
      .to be_valid
    expect { FactoryGirl.create(:user, phone: "") }.to raise_error ActiveRecord::RecordInvalid
  end
end
