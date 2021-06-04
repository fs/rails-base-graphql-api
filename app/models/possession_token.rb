class PossessionToken < ApplicationRecord
  belongs_to :user

  validates :value, :user_id, presence: true
end
