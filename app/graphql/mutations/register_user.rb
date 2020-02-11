module Mutations
  class RegisterUser < BaseMutation
    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(**params)
      result = ::RegisterUser.call(params: params)

      result.user
    end
  end
end
