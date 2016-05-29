require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

RSpec.describe "User creates Host", type: :feature do
  before do
    Geocoder.configure(lookup: :test)

    Geocoder::Lookup::Test.add_stub(
      "11211", [{'latitude' => 40.7093358, 'longitude' => -73.9565551, 'city' => 'Brooklyn', 'state' => 'NY'}]
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

    stub_request(:post, %r{api.mailgun.net/v3/messages})
      .to_return(status: 200)

    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    register_new_facebook_user
  end

  context "creating a new hosting" do
    it 'redirects the user to their homepage with link to the hosting record' do
      create_host
      expect(page).to have_content("Brooklyn, NY 10 guests")
    end
  end

  context "creating a new hosting with blank fields" do
    it 'displays error messages' do
      click_link "I Can Host"
      click_button("Save")
      expect(page).to have_content t('errors.messages.invalid_zipcode')
    end
  end

  scenario 'creating a new hosting with the wrong zip code' do
    click_link "I Can Host"
    fill_in "Where are you located?", with: '1121'
    click_button("Save")
    expect(page).to have_content t('errors.messages.invalid_zipcode')
  end

  scenario "deleting a hosting" do
    create_host
    expect(page).to have_content("Brooklyn, NY 10 guests")
    delete_host
    expect(page).not_to have_content("Brooklyn, NY 10 guests")
    expect(Hosting.with_deleted.last).to_not be_nil
  end

  scenario "updating a hosting guest number" do
    create_host
    expect(page).to have_content("Brooklyn, NY 10 guests")
    click_link 'Brooklyn, NY'
    find("#hosting_max_guests").select(9)
    click_button "Save"
    expect(page).to have_content("Brooklyn, NY 9 guests")
  end

  scenario "updating a hosting with invalid fields" do
    create_host
    click_link 'Brooklyn, NY'
    fill_in "Where are you located?", with: ""
    click_button "Save"
    expect(page).to have_content t('errors.messages.invalid_zipcode')
  end

  scenario "updating a hosting zip code" do
    create_host
    expect(page).to have_content("Brooklyn, NY 10 guests")
    click_link 'Brooklyn, NY'
    fill_in "Where are you located?", with: '63130'
    find("#hosting_max_guests").select(10)
    click_button "Save"
    expect(page).to have_content("63130 10 guests")
  end

  scenario "geocoder does not return city or state" do
    create_host('63130', 1)
    expect(page).to have_content("63130 1 guest")
  end
end
