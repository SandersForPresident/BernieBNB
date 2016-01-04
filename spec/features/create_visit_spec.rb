require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

RSpec.describe "User Creates Visit", type: :feature do
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

  scenario "creating a new visit with no available hosts" do
    create_visit(Date.current, Date.current + 1.days)
    expect(page).to have_content('Nobody here, yet.')
  end

  scenario "missing fields in new visit form" do
    click_link 'Find A Host'
    click_button 'Contact Hosts'

    expect(page).to have_content('Start date is not a valid date')
  end

  scenario "creating a new visit with available hosts" do
    FactoryGirl.create(:user, phone: '2345678901')
    FactoryGirl.create(:hosting, zipcode: '11211', max_guests: 2, host_id: User.last.id)
    create_visit(Date.current, Date.current + 1.days)

    expect(page).to have_content('Hosts near 11211')
  end

  scenario "editing an existing visit" do
    FactoryGirl.create(:hosting, zipcode: '11221', max_guests: 2, host_id: User.last.id)
    create_visit(Date.current, Date.current + 1.days)
    visit user_url(User.last)
    click_link '11211'
    fill_in 'Where are you going?', with: '63130'
    click_button 'Contact Hosts'

    expect(page).to have_content('Nobody here, yet.')

    visit user_url(User.last)

    expect(page).to have_content('63130')
  end

  scenario "deleting an existing visit" do
    create_visit(Date.current, Date.current + 1.days)
    visit user_url(User.last)
    expect(page).to have_content('11211')

    visit edit_visit_url(Visit.last)
    click_link 'Delete'

    expect(page).to_not have_content('11211')
  end

  scenario "new host becomes available for visit" do
    create_visit(Date.current, Date.current + 1.days)
    FactoryGirl.create(:hosting, zipcode: '11221', max_guests: 2, host_id: User.last.id)

    expect(open_last_email).to have_body_text("#{User.last.first_name} just signed up")
  end
end
