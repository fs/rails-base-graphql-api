class UpdateUserForm
  include ActiveModel::Model

  USER_ATTRIBUTES = %i[first_name last_name email password].freeze
  ATTRIBUTES = (USER_ATTRIBUTES + %i[current_password]).freeze

  attr_accessor(*ATTRIBUTES)
  attr_reader :user

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :current_password, existing_password: true, presence: true, unless: -> { password.blank? }
  validates :password, length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED },
                       allow_nil: true, allow_blank: true

  def initialize(user)
    @user = user
    assign_user_attributes
  end

  def attributes
    ATTRIBUTES.index_with { |attribute| public_send(attribute) }
  end

  def assign_attributes(attrs)
    attrs.each do |key, value|
      public_send "#{key}=", value
    end
    self
  end

  def user_attributes
    attributes.slice(*USER_ATTRIBUTES).compact
  end

  def assign_user_attributes
    assign_attributes(user.attributes.symbolize_keys.slice(*USER_ATTRIBUTES))
  end
end
