module Types
  class MutationType < Types::BaseObject
    field :signup, mutation: Mutations::SignUp
    field :signin, mutation: Mutations::SignIn
  end
end
