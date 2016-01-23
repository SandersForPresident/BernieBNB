require 'rails_helper'
require 'spec_helper'
require 'visit'

RSpec.describe Hosting, type: :model do

  before(:each) do
    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "11211", [{'latitude' => 40.7093358, 'longitude' => -73.9565551, 'city' => 'Brooklyn', 'state' => 'New York'}]
    )

    Geocoder::Lookup::Test.add_stub(
      "9131", [{'latitude' => 0, 'longitude' => 0}]
    )

    Geocoder::Lookup::Test.add_stub(
      "913123", [{'latitude' => 1, 'longitude' => 1}]
    )

    Geocoder::Lookup::Test.add_stub(
      "ABC", [{'latitude' => 1, 'longitude' => 1}]
    )
  end

  it "has a valid factory - valid zip code - 5 digits" do
    expect(FactoryGirl.create(:hosting, zipcode: "11211")).to be_valid
  end

  it "adds city, state, latitude and longitude after validation" do
    expect(FactoryGirl.create(:hosting).city).to eq('Brooklyn')
    expect(FactoryGirl.create(:hosting).state).to eq('New York')
  end

  it "is invalid without a zip code - 0 digits" do
    expect { FactoryGirl.create(:hosting, zipcode: nil) }
      .to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with bad zip code - < 5 digits" do
    expect { FactoryGirl.create(:hosting, zipcode: "9131") }
      .to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with bad zip code - > 5 digits" do
    expect { FactoryGirl.create(:hosting, zipcode: "913123") }
      .to raise_error ActiveRecord::RecordInvalid
  end

  it "is invalid with bad zip code - non-digits" do
    expect { FactoryGirl.create(:hosting, zipcode: "ABC") }
      .to raise_error ActiveRecord::RecordInvalid
  end

  it "is valid with a comment" do
    expect(FactoryGirl.create(:hosting, comment: "3 bedrooms and 2 bathrooms")).to be_valid
  end

  it "is valid without a comment" do
    expect(FactoryGirl.create(:hosting, comment: nil))
  end

  it "is softly deleted" do
    hosting = FactoryGirl.create(:hosting)
    hosting.destroy
    expect(Hosting.first).to be_nil
    expect(Hosting.with_deleted.first).to eq(hosting)
  end
end
