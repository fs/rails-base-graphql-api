class Activity < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :event, in: %i[user_registered user_updated]

  validates :title, :body, presence: true
end
