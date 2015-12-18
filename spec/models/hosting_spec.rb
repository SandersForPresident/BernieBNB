require 'rails_helper'
require 'spec_helper'

RSpec.describe Hosting, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:hosting)).to be_valid
  end

  it "is invalid without a zipcode" do
    expect { FactoryGirl.create(:hosting, zipcode: nil) }.to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with an invalid zipcode"
end
