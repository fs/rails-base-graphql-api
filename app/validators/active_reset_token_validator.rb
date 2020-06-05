class ActiveResetTokenValidator < ActiveModel::EachValidator
  TIMEOUT = 15.minutes

  def validate_each(record, _attribute, value)
    return if value.nil? || value >= TIMEOUT.ago

    record.errors[:password_reset_token] << "has expired"
  end
end
