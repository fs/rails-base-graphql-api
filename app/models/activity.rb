class Activity < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :event, in: %i[user_registered user_updated user_reset_password]

  validates :title, :body, presence: true
end
