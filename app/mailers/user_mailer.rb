class UserMailer < ApplicationMailer
  default from: "berniebnb@berniebnb.com"

  def welcome_email(user)
    @user = user
    @url = user_url(@user)
    mail(to: @user.email, subject: 'BernieBNB: Thanks for signing up!',
      template_path: 'user_mailer', template_name: 'welcome_email')
  end

  def new_host_email(visit, hosting)
    @visit, @hosting, @visitor, @host = visit, hosting, visit.user, hosting.user
    @results_url = visit_url(@visit)
    mail(to: @visitor.email, subject: "BernieBNB - New host near #{@visit.zipcode}!",
      template_path: 'user_mailer', template_name: 'new_host_email')
  end

  def contact_host_email(visit, hosting)
    @visit, @hosting, @visitor, @host = visit, hosting, visit.user, hosting.user
    @hosting_url = hosting_url(@hosting)
    mail(to: @host.email, subject: "BernieBNB - You've been contacted!",
      template_path: 'user_mailer', template_name: 'contact_host_email')
  end
end
