# Comment for FeedbackMailer
class FeedbackMailer < ApplicationMailer
  def new_feedback(feedback)
    @feedback = feedback

    mail(
      to: 'berniebnb@berniebnb.com', from: feedback.email.to_s,
      subject: 'Feedback from #{feedback.name}',
      template_path: 'feedback_mailer', template_name: 'feedback_email'
    )
  end
end
