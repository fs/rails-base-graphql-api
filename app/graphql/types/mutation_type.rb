module Types
  class MutationType < Types::BaseObject
    field :register_user, mutation: Mutations::RegisterUser
    field :create_token, mutation: Mutations::CreateToken
  end
end
