module Mutations
  class UpdateToken < BaseMutation
    type Types::AuthenticationType

    def resolve
      if type == "refresh"
        update_token = UpdateTokenPair.call(user: user, token: token, client_uid: client_uid)

        if update_token.success?
          update_token
        else
          execution_error(error_data: update_token.error_data)
        end
      else
        execution_error(error_data: error_data)
      end
    end

    private

    def user
      context[:current_user]
    end

    def token
      context[:token]
    end

    def payload
      @payload ||= JWT.decode(token, ENV["AUTH_SECRET_TOKEN"], true, algorithm: "HS256").first
    rescue JWT::DecodeError
      nil
    end

    def client_uid
      payload["client_uid"]
    end

    def type
      payload["type"]
    end

    def error_data
      { message: "Invalid credentials", status: 401, code: :unauthorized }
    end
  end
end
