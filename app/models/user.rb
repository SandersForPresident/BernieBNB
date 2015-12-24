class User < ActiveRecord::Base
  validates :phone, length: { is: 10, allow_nil: true }
  
  has_many :visits
  has_many :hostings
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.email = auth["info"]["email"]
    end
  end
  
  def phone=(number)
    digits = number.gsub(/\D/, '').split(//)
    digits.shift if digits.length == 11 && digits[0] == "1"

    super(digits.join)
  end
end
