class FilteredActivitiesQuery < BaseFilteredQuery
  def by_first(relation, first)
    relation.limit(first)
  end

  def by_skip(relation, skip)
    relation.offset(skip)
  end
end
