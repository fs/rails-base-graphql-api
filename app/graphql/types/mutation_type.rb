module Types
  class MutationType < Types::BaseObject
    field :signup, mutation: Mutations::SignUp
    field :signin, mutation: Mutations::SignIn
    field :update_token, mutation: Mutations::UpdateToken
    field :update_user, mutation: Mutations::UpdateUser
  end
end
