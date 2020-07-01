class FilteredActivitiesQuery < BaseFilteredQuery
  ALLOWED_PARAMS = [:events].freeze

  def by_events(relation, events)
    relation.where(event: events)
  end
end
