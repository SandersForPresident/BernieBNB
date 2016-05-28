class UserMailer < ApplicationMailer

  def registration_confirmation(user)
    @user = user.decorate

    client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
    message_params = {
      from: default_sender_address,
      to: @user.email,
      subject: "#{t('general.bernie').capitalize} BNB - Thanks for signing up!",
      html: render_to_string(template: "app/views/user_mailer/welcome_email.html.erb").to_str
    }

    client.send_message(ENV['MAILGUN_DOMAIN'], message_params)
    # mail(to: @user.email, subject: t('general.bernie').capitalize + ' BNB - Registration Confirmation')
  end

  def welcome_email(user)
    @user = user.decorate
    # mail(to: @user.email, subject: t('general.bernie').capitalize + ' BNB - Thanks for signing up!',
    #   template_path: 'user_mailer', template_name: 'welcome_email')

    client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
    message_params = {
      from: default_sender_address,
      to: @user.email,
      subject: "#{t('general.bernie').capitalize} BNB - Thanks for signing up!",
      html: render_to_string(template: "app/views/user_mailer/welcome_email.html.erb").to_str
    }
    byebug
    client.send_message(ENV['MAILGUN_DOMAIN'], message_params)
  end

  def test_email(user)
    @user = user
    client = Mailgun::Client.new(ENV['MAILGUN_API_KEY'])
    message_params = {
      from: "some-guy@some-crazy-domain.com",
      to: user,
      subject: 'testing 1, 2',
      text: 'some email body'
    }
    client.send_message(ENV['MAILGUN_DOMAIN'], message_params)
  end

  def new_hosts_digest(visit, visitor, host_data)
    @visit, @visitor = visit, visitor
    @host_data = host_data.reject { |hd| hd[:host].nil? }

    return unless @visitor

    mail(
      to: @visitor.email,
      reply_to: 'DO_NOT_REPLY@berniebnb.com',
      subject: 'BernieBNB - New hosts for your visit!'
    )
  end

  def new_contacts_digest(hosting, host, contact_data)
    @hosting, @host = hosting, host
    @contact_data = contact_data.reject { |cd| cd[:visitor].nil? }

    return if !@host || @contact_data.empty?

    mail(
      to: @host.email,
      reply_to: 'DO_NOT_REPLY@berinebnb.com',
      subject: "BernieBNB - You've been contacted!"
    )
  end

  private

  def default_sender_address
    "notifications@#{ENV['MAILGUN_DOMAIN']}"
  end
end
