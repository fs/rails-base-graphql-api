class ExpirationValidator < ActiveModel::EachValidator
  DEFAULT_TIMEOUT = 1.hour

  def validate_each(record, attribute, value)
    return if value.nil? || (options[:timeout] || DEFAULT_TIMEOUT).since(value).future?

    record.errors.add(attribute, :time_expired)
  end
end
