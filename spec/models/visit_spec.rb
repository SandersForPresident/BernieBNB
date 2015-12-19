require 'rails_helper'

RSpec.describe Visit, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:visit)).to be_valid
  end
  
  it "is invalid without a zipcode" do
    expect { FactoryGirl.create(:visit, zipcode: nil) }
      .to raise_error ActiveRecord::StatementInvalid
  end

  it "is invalid with an invalid zipcode" do
    expect { FactoryGirl.create(:visit, zipcode: "00000") }
      .to raise_error ActiveRecord::StatementInvalid
  end
  
  it "is invalid with a start date in the past" do
    expect { FactoryGirl.create(:visit, start_date: Faker::Date.backward(1)) }
      .to raise_error ActiveRecord::RecordInvalid
  end
end
