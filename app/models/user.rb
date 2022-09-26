class User < ApplicationRecord
  has_secure_password

  before_save :assign_api_key

  validates_presence_of :email

  def self.email_exists?(email)
    user = User.find_by(email: email)
    !user.nil?
  end

  private
    def assign_api_key
      self.api_key = SecureRandom.hex(14)
    end
end
