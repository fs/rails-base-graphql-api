class Activity < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :event, in: %w[user_registered user_logged_in user_login_attempt_failed]

  validates :title, :body, presence: true
end
