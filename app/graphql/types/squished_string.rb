module Types
  class SquishedString < BaseScalar
    def self.coerce_input(input_value, _context)
      input_value.squish
    rescue NoMethodError
      raise GraphQL::CoercionError, "#{input_value.inspect} is not a valid string"
    end

    def self.coerce_result(ruby_value, _context)
      ruby_value.to_s
    end
  end
end
