# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActiveRecord::Base.logger.level = Logger::DEBUG

ActionMailer::Base.smtp_settings = {
  :address        => ENV['MAILGUN_SMTP_SERVER'],
  :port           => ENV['MAILGUN_SMTP_PORT'],
  :authentication => :plain,
  :user_name      => ENV['MAILGUN_SMTP_LOGIN'],
  :password       => ENV['MAILGUN_SMTP_PASSWORD'],
  :domain         => ENV['BASE_DOMAIN'],
  :enable_starttls_auto => true
}
