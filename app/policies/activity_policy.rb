class ActivityPolicy < ApplicationPolicy
  authorize :user, allow_nil: true

  relation_scope do |relation|
    next relation.public_events unless user

    relation.public_events.or(relation.where(user: user))
  end
end
