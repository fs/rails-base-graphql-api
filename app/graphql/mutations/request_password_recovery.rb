module Mutations
  class RequestPasswordRecovery < BaseMutation
    argument :email, String, required: true

    type Types::DetailedMessageType

    def resolve(email:)
      RequestPasswordReset.call(email: email)
    end
  end
end
