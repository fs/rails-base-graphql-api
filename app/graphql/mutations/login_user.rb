module Mutations
  class LoginUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :token, String, null: true

    def resolve(email:, password:)
      result = CreateJwt.call(email: email, password: password)

      if result.success?
        { user: result.user, token: result.token }
      else

      end
    end
  end
end
