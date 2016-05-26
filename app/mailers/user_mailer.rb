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
end
