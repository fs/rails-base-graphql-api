module Mutations
  class CreateUser < BaseMutation
    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :password, String, required: true

    type Types::UserType

    def resolve(email:, first_name:, last_name:, password:)
      User.create(
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: password
      )
    end
  end
end
