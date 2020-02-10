module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
  end
end
