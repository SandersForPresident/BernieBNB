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
end
