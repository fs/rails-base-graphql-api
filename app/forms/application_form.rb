class ApplicationForm
  include ActiveModel::Model

  attr_reader :model

  def initialize(model = nil)
    @model = model
    assign_model_attributes if model
  end

  def assign_attributes(attrs)
    attrs.each do |key, value|
      public_send "#{key}=", value
    end
    self
  end

  def model_attributes
    attributes.slice(*model_attribute_names).compact
  end

  private

  def attributes
    attribute_names.index_with { |attribute| public_send(attribute) }
  end

  def assign_model_attributes
    assign_attributes(model.attributes.symbolize_keys.slice(*model_attribute_names))
  end
end
