# coding: utf-8
require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

RSpec.describe "User Signs Up With Facebook", type: :feature do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    stub_request(:post, %r{mailgun.net/v3/messages})
      .to_return(status: 201)
  end

  scenario 'starts session' do
    authenticate_with_facebook

    expect(page).to have_content( t('information.moredetails') )
  end

  scenario 'completing registration information' do
    authenticate_with_facebook
    fill_in_user_details

    expect(page).to have_content( t('information.emailconfirmsent') )
  end

  scenario 'fill out registration information incorrectly' do
    authenticate_with_facebook
    fill_in t('questions.phonenumber'), with: '5555555556'
    click_button 'Confirm Email'

    expect(page).to have_content( t('errors.messages.blankfirstname') )
  end

  scenario 'confirming registration with email' do
    authenticate_with_facebook
    fill_in_user_details

    confirmation_token = User.last.confirm_token
    confirm_url =
      "http://localhost:3000/users/#{confirmation_token}/confirm_email"
    email_request = a_request(:post, %r{mailgun.net/v3/messages}).with do |req|
      body = URI::decode_www_form(req.body).to_h

      body['html'].match(confirm_url)
    end

    expect(email_request).to have_been_made

    visit confirm_url
    expect(page).to have_content( t('information.findahost') )
  end

  scenario 'register, sign out, sign back in' do
    register_new_facebook_user
    click_link 'Sign Out'
    click_link 'Facebook'

    expect(page).to have_content( t('information.findahost') )
  end

  scenario 'when a blacklisted user attempts to sign in' do
    register_new_facebook_user

    click_link 'Sign Out'

    User.last.update(blacklisted: true)

    click_link 'Facebook'

    expect(page).to have_content 'Authentication failed'
  end

  scenario 'delete account' do
    register_new_facebook_user
    click_link '« Profile'
    wascount = User.count
    click_button 'Delete Account'
    expect(User.count).to eq(wascount - 1)
    expect(page).to have_content('Successfully deleted account')
  end

  scenario 'facebook fails' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials

    authenticate_with_facebook

    # To reset to previous value.
    OmniAuth.config.mock_auth[:facebook] = Rails.application.env_config["omniauth.auth"]

    expect(page).to have_content( t('information.signin') )
  end
end
