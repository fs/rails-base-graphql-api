class ActivityPolicy < ApplicationPolicy
  relation_scope do |relation|
    next relation.public_events unless user

    relation.public_events.or(relation.where(user: user))
  end
end
