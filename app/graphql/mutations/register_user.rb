module Mutations
  class RegisterUser < BaseMutation
    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(**params)
      result = RegisterUserService.call(params)

      if result.success?
        result.user
      else

      end
    end
  end
end
