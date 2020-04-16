module Mutations
  class RegisterUser < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    argument :first_name, String, required: false
    argument :last_name, String, required: false

    field :user, Types::UserType, null: false

    def resolve(**params)
      ::RegisterUser.call(params: params)
    end
  end
end
