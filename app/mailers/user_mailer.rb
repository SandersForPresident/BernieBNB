class UserMailer < ApplicationMailer
  default from: #{t('general.bernie') bnbinfo@gmail.com"}

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

  def new_host_email(visit, hosting)
    @visit, @hosting, @visitor, @host =
      visit.decorate, hosting.decorate, visit.user.decorate, hosting.host.decorate
    @results_url = visit_url(@visit)
    mail(to: @visitor.email,
         from: "DO-NOT-REPLY@" + t('general.bernie') + "bnb.com",
         subject: t('general.bernie').capitalize + " BNB - New host near #{@visit.city || @visit.zipcode}!",
         template_path: 'user_mailer', template_name: 'new_host_email')
  end

  def contact_host_email(visit, hosting)
    @visit, @hosting, @visitor, @host =
      visit.decorate, hosting.decorate, visit.user.decorate, hosting.host.decorate
    @hosting_url = hosting_url(@hosting)
    mail(to: @host.email, reply_to: @visitor.email,
      subject: t('general.bernie').capitalize + " BNB - You've been contacted!",
      template_path: 'user_mailer', template_name: 'contact_host_email')
  end
end
