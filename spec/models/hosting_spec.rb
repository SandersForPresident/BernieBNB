require 'rails_helper'
require 'spec_helper'
require 'visit'

RSpec.describe Hosting, type: :model do

  # To avoid going over geocoding api limits
  before(:each) { sleep(1.0 / 5.0) }

  it "has a valid factory" do
    expect(FactoryGirl.create(:hosting)).to be_valid
  end

  it "is invalid without a zipcode" do
    expect { FactoryGirl.create(:hosting, zipcode: nil) }.to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with an invalid zipcode" do
    expect { FactoryGirl.create(:hosting, zipcode: "00000") }.to raise_error ActiveRecord::StatementInvalid
  end
end
