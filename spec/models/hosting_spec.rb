require 'rails_helper'
require 'spec_helper'
require 'visit'

RSpec.describe Hosting, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.create(:hosting)).to be_valid
  end

  it "is invalid without a zipcode" do
    expect { FactoryGirl.create(:hosting, zipcode: nil) }.to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with an invalid zipcode" do
    expect { FactoryGirl.create(:hosting, zipcode: "00000")}.to raise_error ActiveRecord::StatementInvalid
  end

  describe "::can_host" do
    before :each do
      @denver_three = FactoryGirl.create :hosting,
        max_guests: 3,
        zipcode: "80220"
      @denver_one = FactoryGirl.create :hosting,
        max_guests: 1,
        zipcode: "80220"
      @colorado_springs_three = FactoryGirl.create :hosting,
        max_guests: 3,
        zipcode: "80903"
      @visit = instance_double("Visit", num_travelers: 2, zipcode: "80204")
    end

    it "returns hostings near visitor" do
      expect(Hosting.can_host(@visit)).to eq([@denver_three])
    end
    it "doesn't return hostings fewer spaces than number of travelers" do
      expect(Hosting.can_host(@visit)).to_not include(@denver_one)
    end
  end
end
