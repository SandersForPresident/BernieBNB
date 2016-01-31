require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

RSpec.describe "User creates Host", type: :feature do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    register_new_facebook_user

    Geocoder.configure(:lookup => :test)

    Geocoder::Lookup::Test.add_stub(
      "11211", [{'latitude' => 40.7093358, 'longitude' => -73.9565551}]
    )

    Geocoder::Lookup::Test.add_stub(
      "11225", [{'latitude' => 40.6675, 'longitude' => -73.9856}]
    )

    Geocoder::Lookup::Test.add_stub(
      "63130", [{'latitude' => 38.6682669, 'longitude' => -90.3230806}]
    )

    Geocoder::Lookup::Test.add_stub(
      "1121", [{'latitude' => 38.6682669, 'longitude' => -90.3230806}]
    )


  end

  scenario "creating a new hosting" do
    create_host
    expect(page).to have_content("11211 (10 guests)")
  end

  scenario "creating a new hosting with blank fields" do
    click_link "I Can Host"
    click_button("Save")
    expect(page).to have_content t('errors.messages.invalid_zipcode')
  end

  scenario 'creating a new hosting with the wrong zip code' do
    click_link "I Can Host"
    fill_in "Where are you located?", with: '1121'
    click_button("Save")
    expect(page).to have_content t('errors.messages.invalid_zipcode')
  end

  scenario "deleting a hosting" do
    create_host
    expect(page).to have_content("11211 (10 guests)")
    delete_host
    expect(page).not_to have_content("11211 (10 guests)")
    expect(Hosting.with_deleted.last).to_not be_nil
  end

  scenario "updating a hosting guest number" do
    create_host
    expect(page).to have_content("11211 (10 guests)")
    click_link '11211'
    find("#hosting_max_guests").select(9)
    click_button "Save"
    expect(page).to have_content("11211 (9 guests)")
  end

  scenario "updating a hosting zip code" do
    create_host
    expect(page).to have_content("11211 (10 guests)")
    click_link '11211'
    fill_in "Where are you located?", with: '63130'
    find("#hosting_max_guests").select(10)
    click_button "Save"
    expect(page).to have_content("63130 (10 guests)")
  end

end
