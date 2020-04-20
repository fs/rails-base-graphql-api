module Types
  class MutationType < Types::BaseObject
    field :signup, mutation: Mutations::RegisterUser
    field :signin, mutation: Mutations::CreateToken
  end
end
