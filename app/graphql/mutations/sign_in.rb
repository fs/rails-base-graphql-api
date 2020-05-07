module Mutations
  class SignIn < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    type Types::AuthenticationType

    def resolve(email:, password:)
      create_token = CreateJwt.call(email: email, password: password)

      if create_token.success?
        create_token
      else
        GraphQL::ExecutionError.new "Invalid credentials"
      end
    end
  end
end
