require "rails_helper"

describe Mutations::SignUp do
  include_context "when time is frozen"

  let(:response) { ApplicationSchema.execute(query, {}).as_json }

  let(:registered_user) { User.first }
  let(:access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTU4OTExNzQwMCwianRpIjoiZGMzYzk5NmJjNjk3NDgwNDEx"\
    "OTRjNDYzNWEzNmJlMDQiLCJ0eXBlIjoiYWNjZXNzIn0.RnZk3U3AiEVfenc9tmSZVRWhztmjbM2uBr_JA1k2BcI"
  end
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTU5MTcwNTgwMCwianRpIjoiZGMzYzk5NmJjNjk3NDgwNDE" \
    "xOTRjNDYzNWEzNmJlMDQiLCJ0eXBlIjoicmVmcmVzaCJ9.WrdbN_TLEE97yKy3zXAjKvo9eqVF4cdsRcVdrA7dS7E"
  end
  let(:client_uid) { "#{registered_user.id}-qwerty54321" }

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
    let(:expected_response) do
      {
        "data" => {
          "signup" => {
            "me" => {
              "id" => registered_user.id.to_s,
              "email" => email
            },
            "accessToken" => access_token,
            "refreshToken" => refresh_token
          }
        }
      }
    end

    it "registers a new user" do
      expect(response).to eq expected_response
    end
  end

  context "with invalid data" do
    let(:email) { "bilbo.baggins" }
    let(:expected_response) do
      {
        "data" => {
          "signup" => nil
        },
        "errors" => [
          {
            "message" => "Record Invalid",
            "extensions" => {
              "status" => 422,
              "code" => "unprocessable_entity",
              "detail" => ["Email is invalid"]
            },
            "locations" => [
              {
                "line" => 2,
                "column" => 9
              }
            ],
            "path" => ["signup"]
          }
        ]
      }
    end

    it "returns error" do
      expect(response).to eq expected_response
    end
  end
end
