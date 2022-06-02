module Types
  class SquishedString < BaseScalar
    def self.coerce_input(input_value, _context)
      squished = input_value.try(:squish)
      raise GraphQL::CoercionError, "#{input_value.inspect} is not a valid string" unless squished.is_a? String

      squished
    end

    def self.coerce_result(ruby_value, _context)
      ruby_value.to_s
    end
  end
end
