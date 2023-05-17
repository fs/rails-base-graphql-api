# rubocop:disable GraphQL/ExtractType
module Types
  class MutationType < Types::BaseObject
    description "Mutations"

    field :sign_in, mutation: Mutations::SignIn, description: "Sign in"
    field :sign_out, mutation: Mutations::SignOut, description: "Sign out"
    field :sign_up, mutation: Mutations::SignUp, description: "Sign up"

    field :update_password, mutation: Mutations::UpdatePassword, description: "Update user password"
    field :update_token, mutation: Mutations::UpdateToken, description: "Update short live access token"
    field :update_user, mutation: Mutations::UpdateUser, description: "Update user info"

    field :confirm_user,
          mutation: Mutations::ConfirmUser,
          description: "Confirm user email"
    field :omniauth_sign_in_or_sign_up,
          mutation: Mutations::OmniauthSignInOrSignUp,
          description: "Authenticate with OAuth"
    field :request_password_recovery,
          mutation: Mutations::RequestPasswordRecovery,
          description: "Reset password request"

    field :presign_data,
          mutation: Mutations::PresignData,
          description: "File presign data for upload"
  end
end
# rubocop:enable GraphQL/ExtractType
