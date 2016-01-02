class UserDecorator < Draper::Decorator
  delegate_all

  decorates_association :visits
  decorates_association :hostings
end
