module Types
  class MutationType < Types::BaseObject
    field :signup, mutation: Mutations::SignUp
    field :signin, mutation: Mutations::SignIn
    field :update_token, mutation: Mutations::UpdateToken
    field :signout, mutation: Mutations::SignOut
    field :update_user, mutation: Mutations::UpdateUser
    field :request_password_recovery, mutation: Mutations::RequestPasswordRecovery
    field :presign_data, mutation: Mutations::PresignData
    field :update_password, mutation: Mutations::UpdatePassword
    field :confirm_user, mutation: Mutations::ConfirmUser
    field :omniauth_signin_or_signup, mutation: Mutations::OmniauthSignInOrSignUp
  end
end
