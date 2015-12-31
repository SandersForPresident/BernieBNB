class User < ActiveRecord::Base
  validates :phone, length: { is: 10, allow_nil: true }
  validates :first_name, presence: true, allow_nil: true
  validates :uid, :email, :session_token, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  before_create :create_confirmation_token

  after_initialize :ensure_session_token

  has_many :visits, dependent: :destroy
  has_many :hostings, dependent: :destroy

  def self.generate_secure_token
    SecureRandom::urlsafe_base64(16)
  end

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

  def reset_session_token!
    self.session_token ||= self.class.generate_secure_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_secure_token
  end

  def create_confirmation_token
    self.confirm_token ||= self.class.generate_secure_token
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end
end
