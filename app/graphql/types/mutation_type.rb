module Types
  class MutationType < Types::BaseObject
    field :sign_up, mutation: Mutations::SignUp
    field :sign_in, mutation: Mutations::SignIn
    field :sign_out, mutation: Mutations::SignOut

    field :update_token, mutation: Mutations::UpdateToken
    field :update_user, mutation: Mutations::UpdateUser
    field :update_password, mutation: Mutations::UpdatePassword

    field :confirm_user, mutation: Mutations::ConfirmUser
    field :request_password_recovery, mutation: Mutations::RequestPasswordRecovery
    field :omniauth_sign_in_or_sign_up, mutation: Mutations::OmniauthSignInOrSignUp

    field :presign_data, mutation: Mutations::PresignData
  end
end
