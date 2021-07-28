module Mutations
  class ConfirmUser < BaseMutation
    argument :input, Types::ConfirmUserInput, required: true

    type Types::CurrentUserType

    def resolve(input:)
      result = ::ConfirmUser.call(value: input.value)

      if result.success?
        result.user
      else
        execution_error(error_date: result.error_date)
      end
    end
  end
end
