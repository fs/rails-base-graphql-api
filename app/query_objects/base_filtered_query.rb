class BaseFilteredQuery
  def initialize(relation, filter_params = {}, pagination_params = {})
    @relation = relation
    @filter_params = filter_params
    @pagination_params = pagination_params
  end

  def all
    filtered_relation
      .offset(pagination_params[:offset])
      .limit(pagination_params[:limit])
  end

  private

  attr_reader :filter_params, :pagination_params, :relation

  def filtered_relation
    filter_params.reduce(relation) do |relation, (key, value)|
      send("by_#{key}", relation, value)
    end
  end
end
