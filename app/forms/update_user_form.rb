class UpdateUserForm < ApplicationForm
  USER_ATTRIBUTES = %i[first_name last_name email password avatar].freeze
  ATTRIBUTES = (USER_ATTRIBUTES + %i[current_password]).freeze

  attr_accessor(*ATTRIBUTES)

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :current_password, existing_password: true, presence: true, unless: -> { password.blank? }
  validates :password, length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED },
                       allow_nil: true, allow_blank: true

  def attribute_names
    @attribute_names ||= ATTRIBUTES
  end

  def model_attribute_names
    @model_attribute_names ||= USER_ATTRIBUTES
  end
end
