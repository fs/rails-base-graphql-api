class RefreshToken < ApplicationRecord
  belongs_to :user

  validates :token, :expires_at, :user_id, presence: true

  scope :active, -> { where("expires_at >= ?", Time.current) }
end
