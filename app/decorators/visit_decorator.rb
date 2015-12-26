class VisitDecorator < Draper::Decorator
  delegate_all

  def short_details
    starting = start_date.strftime("%m/%d")
    ending = end_date.strftime("%m/%d")

    "#{zipcode[0...5]} (#{starting} - #{ending})"
  end
end
