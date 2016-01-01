module FeatureTestHelper
  def authenticate_with_facebook
    visit root_path
    click_link 'Facebook'
  end

  def fill_in_user_details
    fill_in "What's your first name?", with: 'Jane'
    fill_in "What's your phone number?", with: '555-555-5555'

    click_button "Send Email Confirmation"
  end

  def register_new_user
    authenticate_with_facebook
    fill_in_user_details
    visit confirm_email_user_url(User.last.confirm_token)
  end
end

RSpec.configure do |config|
  config.include FeatureTestHelper, :type => :feature
end
