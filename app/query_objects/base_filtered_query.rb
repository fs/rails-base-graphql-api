class BaseFilteredQuery
  ALLOWED_PARAMS = [].freeze

  def initialize(relation, filter_params = {})
    @relation = relation
    @filter_params = sanitized_filter_params(filter_params)
  end

  def all
    filter_params.reduce(relation) do |relation, (key, value)|
      method_name = "by_#{key}"
      self.class.private_method_defined?(method_name) ? send(method_name, relation, value) : relation
    end
  end

  private

  attr_reader :relation, :filter_params

  def sanitized_filter_params(params)
    params
      .to_h
      .deep_symbolize_keys
      .reject { |k, v| !self.class::ALLOWED_PARAMS.include?(k) || v.to_s.blank? }
  end
end
