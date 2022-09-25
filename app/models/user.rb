class User < ApplicationRecord
  before_save :assign_api_key

  validates_presence_of :email, :password_digest

  private
    def assign_api_key
      self.api_key = SecureRandom.hex(14)
    end
end
