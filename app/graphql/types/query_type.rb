module Types
  class QueryType < Types::BaseObject
    field :me, Types::UserType, null: true

    def me
      context[:current_user]
    end
  end
end
