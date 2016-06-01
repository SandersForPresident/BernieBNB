require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe "Signup Email" do
    include Rails.application.routes.url_helpers

    before do
      @user = FactoryGirl.create(:user, email: "jojo@yahoo.com", first_name: "Jojo",
        phone: "2345678901")

      stub_request(:post, %r{api.mailgun.net/v3/messages})
        .to_return(status: 200)
    end


    it "should send an email with the correct user information" do
      expected_request = a_request(:post, %r{api.mailgun.net/v3/messages}).with do |req|
        body = URI::decode_www_form(req.body).to_h

        body['from'] == "BernieBNB <notifications@#{ENV['MAILGUN_DOMAIN']}>" &&
          body['to'] == @user.email &&
          body['subject'] == "#{t('general.bernie').capitalize} BNB - Thanks for signing up!" &&
          body['html'].match(/Hi #{@user.first_name},/) &&
          body['html'].match(/You can add, edit or delete your travel/) &&
          body['html'].match(user_url(@user))
      end

      UserMailer.welcome_email(@user).deliver_now

      expect(expected_request).to have_been_made
    end
  end
end
