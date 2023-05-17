# rubocop:disable GraphQL/ExtractType
module Types
  class MutationType < Types::BaseObject
    description "Mutations"

    field :confirm_user, mutation: Mutations::ConfirmUser, description: "Confirm user email"
    field :omniauth_signin_or_signup,
          mutation: Mutations::OmniauthSignInOrSignUp,
          description: "Authenticate with OAuth"
    field :presign_data, mutation: Mutations::PresignData, description: "File presign data for upload"
    field :request_password_recovery,
          mutation: Mutations::RequestPasswordRecovery,
          description: "Reset password request"
    field :signin, mutation: Mutations::SignIn, description: "Sign in"
    field :signout, mutation: Mutations::SignOut, description: "Sign out"
    field :signup, mutation: Mutations::SignUp, description: "Sign up"
    field :update_password, mutation: Mutations::UpdatePassword, description: "Update user password"
    field :update_token, mutation: Mutations::UpdateToken, description: "Update short live access token"
    field :update_user, mutation: Mutations::UpdateUser, description: "Update user info"
  end
end
# rubocop:enable GraphQL/ExtractType
