class FilteredActivitiesQuery < BaseFilteredQuery
  ALLOWED_PARAMS = [:events].freeze

  private

  def by_events(relation, events)
    relation.where(event: events)
  end
end
