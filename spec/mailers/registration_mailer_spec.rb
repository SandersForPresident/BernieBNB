require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "Registration Email" do
    include Rails.application.routes.url_helpers

    before do
      @user = FactoryGirl.create(:user, email: 'auser@gmail.com', first_name: "Joe", phone: "6541537596")

      stub_request(:post, %r{api.mailgun.net/v3/messages})
        .to_return(status: 200)
    end

    it "should send an email with the correct user information" do
      expected_request = a_request(:post, %r{api.mailgun.net/v3/messages}).with do |req|
        body = URI::decode_www_form(req.body).to_h

        body['from'] == "BernieBNB <notifications@#{ENV['MAILGUN_DOMAIN']}>" &&
          body['to'] == @user.email &&
          body['subject'] == "Bernie BNB - Confirm Your Email" &&
          body['html'].match(/Hi #{@user.first_name},/) &&
          body['html'].match(/#{@user.confirm_token}/)
      end

      UserMailer.registration_confirmation(@user).deliver_now

      expect(expected_request).to have_been_made
    end
  end
end
