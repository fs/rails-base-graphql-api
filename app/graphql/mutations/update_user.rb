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
      update_user = update_user_interactor(user_params).constantize.call(user: current_user, user_params: user_params)

      if update_user.success?
        update_user
      else
        execution_error(error_data: update_user.error_data)
      end
    end

    private

    def update_user_interactor(params)
      params.include?(:password) ? "::UpdateUser" : "UpdateUserAttributes"
    end
  end
end
