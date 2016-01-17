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

  scenario 'Visitor is notified when new host is available' do
    register_new_facebook_user
    create_visit

    expect(page).to have_content('Nobody here, yet.')

    FactoryGirl.create(:user, first_name: 'Jane')
    FactoryGirl.create(:hosting,
      host_id: User.last.id, zipcode: '11221', max_guests: 10)

    expect(last_email_sent).to deliver_to(User.first.email)
    expect(open_last_email).to have_subject('Bernie BNB - New host near 11211!')
    expect(open_last_email).to have_content('Jane just signed up')
  end

  scenario 'Visitor finds and contacts a host' do
    FactoryGirl.create(:user, first_name: 'Jane')
    FactoryGirl.create(:hosting,
      host_id: User.last.id, zipcode: '11221', max_guests: 10)
    register_new_facebook_user
    create_visit
    click_link("Contact")
    click_link("Send my contact info")

    expect(page).to have_content("Successfully contacted Jane")
    expect(last_email_sent).to deliver_to(User.first.email)
    expect(open_last_email).to have_subject("Bernie BNB - You've been contacted!")
    expect(Hosting.last.contact_count).to eq(1)
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
    expect(page).to have_content("Successfully contacted Jane")
  end
end
