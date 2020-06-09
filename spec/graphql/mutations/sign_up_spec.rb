require "rails_helper"

describe Mutations::SignUp do
  include_context "when time is frozen"

  let(:registered_user) { User.first }
  let(:access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTU4OTExNzQwMCwianRpIjoiZGMzYzk5NmJjNjk3NDgwNDEx"\
    "OTRjNDYzNWEzNmJlMDQiLCJ0eXBlIjoiYWNjZXNzIn0.RnZk3U3AiEVfenc9tmSZVRWhztmjbM2uBr_JA1k2BcI"
  end
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTU5MTcwNTgwMCwianRpIjoiZGMzYzk5NmJjNjk3NDgwNDE" \
    "xOTRjNDYzNWEzNmJlMDQiLCJ0eXBlIjoicmVmcmVzaCJ9.WrdbN_TLEE97yKy3zXAjKvo9eqVF4cdsRcVdrA7dS7E"
  end

  let(:query) do
    <<-GRAPHQL
      mutation {
        signup(
          email: "#{email}",
          password: "TheRing"
        ) {
          me {
            id
            email
          }
          accessToken
          refreshToken
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    let(:email) { "bilbo.baggins@shire.com" }

    it_behaves_like "graphql request", "registers a new user" do
      let(:fixture_path) { "json/acceptance/graphql/signup.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:accessToken|:refreshToken/,
          ":id" => registered_user.id,
          ":accessToken" => access_token,
          ":refreshToken" => refresh_token
        )
      end
    end
  end

  context "with invalid data" do
    let(:email) { "bilbo.baggins" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/signup_wrong.json" }
    end
  end
end
