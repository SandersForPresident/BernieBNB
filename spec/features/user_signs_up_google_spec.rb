require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

RSpec.describe "User Signs Up", type: :feature do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
  end

  scenario 'starts session' do
    authenticate_with_google

    expect(page).to have_content( t('information.moredetails') )
  end

  scenario 'completing registration information' do
    skip "17"
    authenticate_with_google
    fill_in_user_details

    #save_and_open_page  # Email can't be blank" and "Email is invalid"
    expect(page).to have_content( t('information.emailconfirmsent') )
  end

  scenario 'fill out registration information incorrectly' do
    authenticate_with_google
    fill_in t('questions.phonenumber'), with: '5555555556'
    click_button 'Confirm Email'

    expect(page).to have_content( t('errors.messages.blankfirstname') )
  end

  scenario 'confirming registration with email' do
    skip "32"
    authenticate_with_google
    fill_in_user_details

    confirmation_token = User.last.confirm_token
    confirm_url =
      "http://localhost:3000/users/#{confirmation_token}/confirm_email"
    expect(open_last_email).to have_body_text(confirm_url)

    visit confirm_url
    expect(page).to have_content( t('information.findahost') )
  end

  scenario 'register, sign out, sign back in' do
    skip "45"
    register_new_google_user
    click_link 'Sign Out'
    click_link 'Google'

    expect(page).to have_content( t('information.findahost') )
  end

  scenario 'google fails' do
    skip "53"
    OmniAuth.config.mock_auth[:google] = :invalid_credentials

    authenticate_with_google

    # To reset to previous value.
    OmniAuth.config.mock_auth[:google] = Rails.application.env_config["omniauth.auth"]

    expect(page).to have_content( t('information.signin') )
  end
end
