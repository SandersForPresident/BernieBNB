class UserMailer < ApplicationMailer
  default from: 'notifications@berniebnb.com'

  def registration_confirmation(user)
    @user = user.decorate
    mail(to: @user.email, subject: t('general.bernie').capitalize + ' BNB - Registration Confirmation')
  end

  def welcome_email(user)
    @user = user.decorate
    @url = user_url(@user)
    mail(to: @user.email, subject: t('general.bernie').capitalize + ' BNB - Thanks for signing up!',
      template_path: 'user_mailer', template_name: 'welcome_email')
  end

  def new_hosts_digest(visit, visitor, host_data)
    @visit, @visitor, @host_data = visit, visitor, host_data
    return unless @visitor && @host_data.host

    mail(
      to: @visitor.email,
      reply_to: 'DO_NOT_REPLY@berniebnb.com',
      subject: 'BernieBNB - New hosts for your visit!'
    )
  end

  def new_contacts_digest(hosting, host, contact_data)
    @hosting, @host, @contact_data = @hosting, @host, @contact_data
    return unless @host && @contact_data.visitor

    mail(
      to: @host.email,
      reply_to: 'DO_NOT_REPLY@berinebnb.com',
      subject: "BernieBNB - You've been contacted!"
    )
  end
end
