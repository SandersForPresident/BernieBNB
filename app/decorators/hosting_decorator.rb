class HostingDecorator < Draper::Decorator
  delegate_all

  def short_details
    location = city? && state? ? "#{city}, #{state.to_s}" : zipcode
    guests = max_guests > 1 ? " (#{max_guests} guests)" : " (#{max_guests} guest)"
    location << guests
  end
end
