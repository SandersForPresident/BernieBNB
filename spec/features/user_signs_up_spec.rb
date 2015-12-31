require 'spec_helper'

feature "User signs up with facebook" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  scenario 'starts session' do
    visit root_path
    click_link 'Facebook'

    expect(page).to have_content('Please fill out a few more')
  end

  scenario 'completing registration information' do
    visit root_path
    click_link 'Facebook'

    fill_in "What's your first name?", with: 'Jane'
    fill_in "What's your phone number?", with: '555-555-5555'

    click_button "Send Email Confirmation"

    expect(page).to have_content('Email confirmation sent')
  end

  scenario 'facebook fails' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials

    visit root_path
    click_link 'Facebook'

    expect(page).to have_content('Sign In')
  end
end
