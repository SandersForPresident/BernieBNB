class User < ActiveRecord::Base
  validates :phone, length: { is: 10, allow_nil: true }
  validates :first_name, presence: true, allow_nil: true
  validates :uid, :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

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
