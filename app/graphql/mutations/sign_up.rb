module Mutations
  class SignUp < BaseMutation
    argument :email, String, required: true
    argument :password, String, required: true

    argument :first_name, String, required: false
    argument :last_name, String, required: false

    field :user, Types::UserType, null: false

    def resolve(**params)
      result = ::RegisterUser.call(params: params)
    end
  end
end
