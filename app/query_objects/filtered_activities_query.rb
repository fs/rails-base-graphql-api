class FilteredActivitiesQuery < BaseFilteredQuery
  ALLOWED_PARAMS = %i(event).freeze

  private

  def by_event(relation, event)
    relation.where(event: event)
  end
end
