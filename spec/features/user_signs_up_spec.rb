require 'spec_helper'

feature "User signs up" do
  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  scenario 'with facebook' do
    visit root_path
    click_link 'Facebook'

    expect(page).to have_content('Please fill out a few more')
  end

  scenario 'facebook fails' do
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials

    visit root_path
    click_link 'Facebook'

    expect(page).to have_content('Sign In')
  end
end
