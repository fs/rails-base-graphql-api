module Types
  class QueryType < Types::BaseObject
    field :user, Types::UserType, null: false do
      description "Find User by ID"
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end
  end
end
