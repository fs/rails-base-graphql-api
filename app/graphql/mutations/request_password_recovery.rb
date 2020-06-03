module Mutations
  class RequestPasswordRecovery < BaseMutation
    argument :email, String, required: true

    type Types::AuthenticationType

    def resolve(email:)
      ApplicationMailer.password_recovery(User.find_by(email: email)).deliver_now

      { message: "ok" }
    end
  end
end
