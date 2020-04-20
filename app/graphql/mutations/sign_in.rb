module Mutations
  class SignIn < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :token, String, null: true
    field :me, Types::UserType, null: true

    def resolve(email:, password:)
      create_token = CreateJwt.call(email: email, password: password)

      if create_token.success?
        { token: create_token.token, me: create_token.user }
      else
        GraphQL::ExecutionError.new "Invalid credentials"
      end
    end
  end
end
