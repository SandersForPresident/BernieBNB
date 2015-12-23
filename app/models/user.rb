class User < ActiveRecord::Base
  validates :phone, length: { is: 10 }
  
  has_many :visits
  has_many :hostings
  
  def phone=(number)
    digits = number.gsub(/\D/, '').split(//)
    digits.shift if digits.length == 11 && digits[0] == "1"
    
    @phone = digits
  end
end
