module Mutations
  class ConfirmUser < BaseMutation
    argument :value, String, required: true

    type Types::CurrentUserType

    def resolve(options)
      result = ::ConfirmUser.call(options)

      if result.success?
        result.user
      else
        execution_error(error_date: result.error_date)
      end
    end
  end
end
