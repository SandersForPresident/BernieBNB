require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

RSpec.describe "User creates Host", type: :feature do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    register_new_user

    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "11211", [{'latitude' => 40.7093358, 'longitude' => -73.9565551}]
    )
    Geocoder::Lookup::Test.add_stub(
      "11221", [{'latitude' => 40.6903213, 'longitude' => -73.9271644}]
    )
    Geocoder::Lookup::Test.add_stub(
      "63130", [{'latitude' => 38.6682669, 'longitude' => -90.3230806}]
    )
  end
end
