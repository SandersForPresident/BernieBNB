require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

RSpec.describe "Visitor contacts host", type: :feature do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      '11211', [{'latitude' => 40.7093358, 'longitude' => -73.9565551}]
    )
    Geocoder::Lookup::Test.add_stub(
      '11221', [{'latitude' => 40.6903213, 'longitude' => -73.9271644}]
    )
  end

  scenario 'Visitor finds and contacts a host' do
    user = FactoryGirl.create(:user, first_name: 'Jane')
    FactoryGirl.create(:hosting,
      host_id: user.id, zipcode: '11221', max_guests: 10)
    register_new_facebook_user
    create_visit
    click_link("Contact")
    click_link("Send my contact info")

    expect(page).to have_content("We will send Jane your contact info!")
  end

  scenario 'Visitor tries to contact host twice for same visit' do
    FactoryGirl.create(:user, first_name: 'Jane')
    FactoryGirl.create(:hosting,
      host_id: User.last.id, zipcode: '11221', max_guests: 10)
    register_new_facebook_user
    create_visit
    click_link("Contact")
    click_link("Send my contact info")

    expect(page).to have_content("Contacted")
  end

  scenario 'Visitor contacts a host again for a second visit' do
    FactoryGirl.create(:user, first_name: 'Jane')
    FactoryGirl.create(:hosting,
      host_id: User.last.id, zipcode: '11221', max_guests: 10)
    register_new_facebook_user
    create_visit
    click_link("Contact")
    click_link("Send my contact info")

    visit user_url(User.last)
    create_visit
    click_link("Contact")
    click_link("Send my contact info")
    expect(page).to have_content("We will send Jane your contact info!")
  end
end
