require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe "Signup Email" do
    include EmailSpec::Helpers
    include EmailSpec::Matchers
    # include ActionController::UrlWriter - old rails
    include Rails.application.routes.url_helpers

    before(:all) do
      @user = FactoryGirl.create(:user, email: "jojo@yahoo.com", first_name: "Jojo",
        phone: "2345678901")
      @email = UserMailer.welcome_email(@user).deliver_now
    end

    it "expect be set to be delivered to the email passed in" do
      expect(@email).to deliver_to("jojo@yahoo.com")
    end

    it "expect to have the correct subject" do
      expect(@email).to have_subject(/#{t('general.bernie').capitalize} BNB - Thanks for signing up!/)
    end

    it "expect to contain the user's message in the mail body" do
      expect(@email).to have_body_text(@user.first_name)
      expect(@email).to have_body_text(/Thanks for signing up with #{t('general.bernie').capitalize}BNB!/)
      expect(@email).to have_body_text(/You can add, edit or delete your travel/)
      expect(@email).to have_body_text(/host requests anytime here:/)
      expect(@email).to have_body_text(/Legal Disclaimer: By agreeing to use this service/)
    end

  end
end
