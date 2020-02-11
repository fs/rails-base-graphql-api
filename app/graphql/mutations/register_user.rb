module Mutations
  class RegisterUser < BaseMutation
    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: false
    field :errors, [String], null: true

    def resolve(**params)
      result = ::RegisterUser.call(params: params)

      { user: result.user, errors: result.user.errors.full_messages }
    end
  end
end
