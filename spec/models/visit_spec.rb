require 'rails_helper'

RSpec.describe Visit, type: :model do

  before(:each) do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "11211", [{'latitude' => 40.7093358, 'longitude' => -73.9565551}]
    )

    Geocoder::Lookup::Test.add_stub(
      "9131", [{'latitude' => 0, 'longitude' => 0}]
    )

  end

  it "has a valid factory" do
    expect(FactoryGirl.create(:visit, zipcode: "11211")).to be_valid
  end

  it "is invalid without a zipcode" do
    expect { FactoryGirl.create(:visit, zipcode: nil) }
      .to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with bad zipcode" do
    expect { FactoryGirl.create(:visit, zipcode: "9131") }
      .to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with a start date in the past" do
    expect do
      FactoryGirl.create(
        :visit,
        start_date: Faker::Date.backward(1),
        zipcode: "11211"
      )
    end.to raise_error ActiveRecord::RecordInvalid
  end

  it "requires an end date after start date" do
    expect do
      FactoryGirl.create(:visit,
                         zipcode: "11211",
                         start_date: Date.today + 5.days,
                         end_date: Date.today)
    end.to raise_error ActiveRecord::RecordInvalid
  end
end
