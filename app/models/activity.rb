class Activity < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :event, in: %w[user_registered reset_password_request]

  validates :title, :body, presence: true
end
