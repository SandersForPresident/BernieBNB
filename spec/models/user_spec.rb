require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it "has a valid factory - 10 chars" do
    expect(FactoryGirl.create(:user, phone: "2345678901")).to be_valid
  end

  it "is not valid without a Uid" do
    expect { FactoryGirl.create(:user, uid: nil, phone: "2345678901") }
      .to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:user, uid: nil, phone: "2345678901") }
      .to raise_error(/Uid can't be blank/)
  end

  it "allows no email, but if present, can't be blank" do
    expect(FactoryGirl.create(:user, phone: "2345678901", email: nil)).to be_valid
    expect { FactoryGirl.create(:user, email: "", phone: "2345678901") }
      .to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:user, email: "", phone: "2345678901") }
      .to raise_error(/Email can't be blank, Email is invalid/)
  end

  it "allows no first name, but if present, can't be blank" do
    expect(FactoryGirl.create(:user, first_name: nil, phone: "2345678901")).to be_valid
    expect { FactoryGirl.create(:user, first_name: "", phone: "2345678901") }
      .to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:user, first_name: "", phone: "2345678901") }
      .to raise_error(/First name can't be blank/)
  end

  it "automatically generates a session token on creation" do
    user = FactoryGirl.create(:user, phone: "2345678901")
    expect(user.session_token).to_not be_nil
  end

  it "allows no phone number, but if present, can't be blank - 0 chars" do
    expect(User.create(uid: SecureRandom.urlsafe_base64(17),
      email: "test@fakemail.com", phone: "2345678901")).to be_valid
    expect { FactoryGirl.create(:user, phone: "") }
      .to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:user, phone: "") }
      .to raise_error(/is too short/)
  end

  it "bad phone number -- 1 in front - 10 chars" do
    expect { FactoryGirl.create(:user, phone: "1234567890") }
      .to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:user, phone: "1234567890") }
      .to raise_error(/is too short/)
  end

  it "bad phone number -- 11 digits (too long) - 11 chars" do
    expect { FactoryGirl.create(:user, phone: "23456789012") }
      .to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:user, phone: "23456789012") }
      .to raise_error(/is too long/)
  end

  it "has a valid factory - 11 chars" do
    expect(FactoryGirl.create(:user, phone: "404-5551212")).to be_valid
    expect(FactoryGirl.create(:user, phone: "404.5551212")).to be_valid
  end

  it "has a valid factory - with hyphens/dashes - 12 chars" do
    expect(FactoryGirl.create(:user, phone: "404-555-1212")).to be_valid

  end

  it "has a valid factory - with periods - 12 chars" do
    expect(FactoryGirl.create(:user, phone: "404.555-1212")).to be_valid
  end

  it "has a valid factory - with paraentheses - 13 chars" do
    expect(FactoryGirl.create(:user, phone: "(404)555-1212")).to be_valid
  end

  it "has a valid factory - with hyphens/dashes and leadinig '1' - 14 chars" do
    expect(FactoryGirl.create(:user, phone: "1-404-555-1212")).to be_valid
  end

  it "has a valid factory - with paraentheses and blank - 14 chars" do
    expect(FactoryGirl.create(:user, phone: "(404) 555-1212")).to be_valid
  end

  it "has a valid factory - with periods and leadning '1' - 14 chars" do
    expect(FactoryGirl.create(:user, phone: "1.404.555-1212")).to be_valid
  end

  it "has a valid factory - international - leading '+' char - 14 chars" do
    expect(FactoryGirl.create(:user, phone: "+45 404 555121")).to be_valid
  end

  it "has a valid factory - with periods and leadning '1' - 15 chars" do
    expect(FactoryGirl.create(:user, phone: "1-(404)555.1212")).to be_valid
  end

  it "has a valid factory - international - leading '+' char - 15 chars" do
    expect(FactoryGirl.create(:user, phone: "+45.404-555121")).to be_valid
  end

  it "has a valid factory - with periods and leadning '1' - 16 chars" do
    expect(FactoryGirl.create(:user, phone: "1-(404)-555.1212")).to be_valid
  end

  it "has a valid factory - international - leading '+' char - 17 chars" do
    expect(FactoryGirl.create(:user, phone: "+45.(404)-555121")).to be_valid
  end

  it "bad phone number -- 17 digits (too long) - 17 chars" do
    expect { FactoryGirl.create(:user, phone: "23456789012345678") }
      .to raise_error ActiveRecord::RecordInvalid
    expect { FactoryGirl.create(:user, phone: "23456789012345678") }
      .to raise_error(/is too long/)
  end
end
