class BaseFilteredQuery
  ALLOWED_PARAMS = [].freeze

  def initialize(relation, filter_params = {}, pagination_params = {})
    @relation = relation
    @filter_params = sanitized_filter_params(filter_params)
    @pagination_params = sanitized_pagination_params(pagination_params)
  end

  def all
    filtered_relation
      .offset(pagination_params[:offset])
      .limit(pagination_params[:limit])
  end

  attr_reader :filter_params, :pagination_params, :relation

  private

  def filtered_relation
    filter_params.reduce(relation) do |relation, (key, value)|
      method_name = "by_#{key}"
      self.class.private_method_defined?(method_name) ? send(method_name, relation, value) : relation
    end
  end

  def sanitized_filter_params(params)
    params
      .to_h
      .deep_symbolize_keys
      .reject { |k, v| !self.class::ALLOWED_PARAMS.include?(k) || v.to_s.blank? }
  end

  def sanitized_pagination_params(params)
    params
      .to_h
      .symbolize_keys
      .reject { |k, v| !%i[limit offset].include?(k) || v.to_s.blank? }
  end
end
