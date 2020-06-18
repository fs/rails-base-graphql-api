class Activity < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :event, in: %w[user_registered]

  validates :title, :body, presence: true
end
