class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :visits
  decorates_association :hostings

  def formatted_phone
    "#{phone[0..2]}-#{phone[3..5]}-#{phone[5..9]}"
  end
end
