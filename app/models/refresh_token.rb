class RefreshToken < ApplicationRecord
  belongs_to :user

  validates :token, :expires_at, :user_id, :client_uid, presence: true

  scope :active, -> { where("expires_at >= ?", Time.current) }
end
