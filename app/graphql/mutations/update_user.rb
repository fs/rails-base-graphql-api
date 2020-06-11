module Mutations
  class UpdateUser < BaseMutation
    include AuthenticableGraphqlUser

    argument :email, String, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :current_password, String, required: false
    argument :password, String, required: false

    type Types::AuthenticationType

    def resolve(**user_params)
      update_user = ::UpdateUser.call(
        user: context[:current_user], user_params: user_params
      )

      if update_user.success?
        update_user
      else
        execution_error(error_data: update_user.error_data)
      end
    end
  end
end
