module Types
  class MutationType < Types::BaseObject
    field :signup, mutation: Mutations::SignUp
    field :signin, mutation: Mutations::SignIn
    field :update_user, mutation: Mutations::UpdateUser
    field :request_password_recovery, mutation: Mutations::RequestPasswordRecovery
    field :update_password, mutation: Mutations::UpdatePassword
  end
end
