class User < ApplicationRecord
  has_secure_password
  has_secure_token :password_reset_token

  has_many :activities, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
