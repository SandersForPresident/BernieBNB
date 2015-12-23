class User < ActiveRecord::Base
  # validates :phone, length: { is: 10 }
  
  has_many :visits
  has_many :hostings
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
    end
  end
  
  def phone=(number)
    digits = number.gsub(/\D/, '').split(//)
    digits.shift if digits.length == 11 && digits[0] == "1"
    
    @phone = digits
  end
end
