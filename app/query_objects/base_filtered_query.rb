class BaseFilteredQuery
  def initialize(relation, filter_params = {})
    @relation = relation
    @filter_params = filter_params
  end

  def all
    filter_params.reduce(relation) do |relation, (key, value)|
      public_send("by_#{key}", relation, value)
    end
  end

  private

  attr_reader :relation, :filter_params
end
