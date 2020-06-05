class UpdateUserPasswordForm
  include ActiveModel::Model

  ATTRIBUTES = %i[password password_reset_sent_at].freeze

  attr_accessor(*ATTRIBUTES)
  attr_reader :user

  validates :password, length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }, presence: true
  validates :password_reset_sent_at, active_reset_token: true, presence: true

  def initialize(user)
    @user = user
    assign_user_attributes
  end

  def assign_attributes(attrs)
    attrs.each do |key, value|
      public_send "#{key}=", value
    end
    self
  end

  def user_attributes
    attributes.slice(*ATTRIBUTES).compact
  end

  private

  def attributes
    ATTRIBUTES.index_with { |attribute| public_send(attribute) }
  end

  def assign_user_attributes
    assign_attributes(user.attributes.symbolize_keys.slice(*ATTRIBUTES))
  end
end
