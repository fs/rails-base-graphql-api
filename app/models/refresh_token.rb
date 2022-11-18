class RefreshToken < ApplicationRecord
  belongs_to :user

  validates :token, :expires_at, presence: true

  scope :active, -> { where("expires_at >= ?", Time.current) }
end
