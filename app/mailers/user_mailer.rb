class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def registration_confirmation(user)
    @user = user.decorate

    deliver_message(
      from: default_sender_address,
      to: user.email,
      subject: "#{t('general.bernie').capitalize} BNB - Confirm Your Email",
      html: template("user_mailer/registration_confirmation.html.erb")
    )
  end

  def welcome_email(user)
    @user = user.decorate

    deliver_message(
      from: default_sender_address,
      to: @user.email,
      subject: "#{t('general.bernie').capitalize} BNB - Thanks for signing up!",
      html: template("user_mailer/welcome_email.html.erb")
    )
  end

  def new_hosts_digest(visit, visitor, host_data)
    @visit, @visitor = visit, visitor
    @host_data = host_data.reject { |hd| hd[:host].nil? }

    return unless @visitor

    deliver_message(
      from: default_sender_address,
      to: @visitor.email,
      'h:Reply-To' => 'DO-NOT-REPLY@berniebnb.com',
      subject: 'BernieBNB - New hosts for your visit!',
      html: template("user_mailer/new_hosts_digest.html.erb")
    )
  end

  def new_contacts_digest(hosting, host, contact_data)
    @hosting, @host = hosting, host
    @contact_data = contact_data.reject { |cd| cd[:visitor].nil? }

    return if !@host || @contact_data.empty?

    deliver_message(
      from: default_sender_address,
      to: @host.email,
      'h:Reply-To' => 'DO-NOT-REPLY@berniebnb.com',
      subject: "BernieBNB - You've been contacted!",
      html: template("user_mailer/new_contacts_digest.html.erb")
    )
  end

  def goodbye_message(user)
    @user = user

    deliver_message(
      from: "BernieBNB <berniebnbinfo@gmail.com>",
      to: @user.email,
      subject: "A Message From BernieBNB",
      html: template("user_mailer/goodbye_message.html.erb")
    )
  end

  def staying_on_message(user)
    @user = user

    deliver_message(
      from: "BernieBNB <berniebnbinfo@gmail.com>",
      to: @user.email,
      subject: "What About Philadelphia?",
      html: template("user_mailer/staying_on_message.html.erb")
    )
  end

  private

  def deliver_message(message_params)
    client.send_message(ENV['MAILGUN_DOMAIN'], message_params)
  end

  def client
    Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
  end

  def default_sender_address
    "BernieBNB <notifications@#{ENV['BASE_DOMAIN']}>"
  end

  def template(path)
    template = ERB.new(
      File.read("#{Rails.root}/app/views/#{path}")
    )

    template.result(binding)
  end
end
