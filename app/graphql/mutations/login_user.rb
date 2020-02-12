module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true

    def resolve(email:, password:)
      result = CreateJwt.call(email: email, password: password)
      if result.success?
        result
      else
        GraphQL::ExecutionError.new "Invalid credentials"
      end
    end
  end
end
