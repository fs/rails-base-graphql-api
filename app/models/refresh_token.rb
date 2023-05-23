class RefreshToken < ApplicationRecord
  belongs_to :user
  belongs_to :original_token, class_name: "RefreshToken", optional: true

  has_one :substitution_token, class_name: "RefreshToken", foreign_key: :original_token_id,
                               dependent: :destroy, inverse_of: :original_token

  validates :token, :expires_at, presence: true
  validates :token, uniqueness: true
  validates :original_token_id, uniqueness: true, allow_blank: true

  scope :active, -> { where("expires_at >= ?", Time.current) }
end
