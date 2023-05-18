class ActivityPolicy < ApplicationPolicy
  relation_scope do |relation|
    relation.where(user: user)
  end
end
