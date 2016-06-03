require 'spec_helper'
require 'rails_helper'
require_relative '../support/feature_test_helper'

describe 'redirecting after sign in' do
  before do
    Rails.application.env_config['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]

    Geocoder.configure(lookup: :test)
    Geocoder::Lookup::Test.add_stub(
      '11211', [{'latitude' => 40.7093358, 'longitude' => -73.9565551, 'city' => 'Brooklyn', 'state' => 'NY'}]
    )
    stub_request(:post, %r{mailgun.net/v3/messages})
      .to_return(status: 201)
  end

  before(:each) do
    register_new_facebook_user

    click_link 'Sign Out'
  end

  context 'when signing in from the homepage' do
    it 'takes the user to their home screen' do
      authenticate_with_facebook

      expect(page).to have_content('Signed in!')
    end
  end

  context 'when redirected to sign in page from another route' do
    let(:hosting) do
      FactoryGirl.create(:hosting, host: User.last)
    end

    it 'takes the user to the page they tried to access' do
      visit edit_hosting_url(hosting)

      expect(page).to have_content('Sign In Using...')
      click_link 'Facebook'

      expect(current_url).to eq(edit_hosting_url(hosting))
    end
  end
end
