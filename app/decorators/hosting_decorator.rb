class HostingDecorator < Draper::Decorator
  delegate_all

  def short_details
    "#{zipcode[0...5]} (#{max_guests} guests)"
  end
end
