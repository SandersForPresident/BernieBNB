class UserMailer < ApplicationMailer
  default from: "berniebnb@berniebnb.com"

  def registration_confirmation(user)
    @user = user.decorate
    mail(to: @user.email, subject: 'Bernie BNB - Registration Confirmation')
  end

  def welcome_email(user)
    @user = user.decorate
    @url = user_url(@user)
    mail(to: @user.email, subject: 'Bernie BNB - Thanks for signing up!',
      template_path: 'user_mailer', template_name: 'welcome_email')
  end

  def new_host_email(visit, hosting)
    @visit, @hosting, @visitor, @host =
      visit.decorate, hosting.decorate, visit.user.decorate, hosting.host.decorate
    @results_url = visit_url(@visit)
    mail(to: @visitor.email, subject: "Bernie BNB - New host near #{@visit.zipcode}!",
      template_path: 'user_mailer', template_name: 'new_host_email')
  end

  def contact_host_email(visit, hosting)
    @visit, @hosting, @visitor, @host =
      visit.decorate, hosting.decorate, visit.user.decorate, hosting.host.decorate
    @hosting_url = hosting_url(@hosting)
    mail(to: @host.email, subject: "Bernie BNB - You've been contacted!",
      template_path: 'user_mailer', template_name: 'contact_host_email')
  end
end
