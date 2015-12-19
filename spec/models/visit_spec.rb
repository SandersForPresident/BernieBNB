require 'rails_helper'

RSpec.describe Visit, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:visit)).to be_valid
  end
end
