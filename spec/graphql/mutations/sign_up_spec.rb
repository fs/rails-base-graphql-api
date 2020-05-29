require "rails_helper"

describe Mutations::SignUp do
  include_context "when time is frozen"

  let(:response) { ApplicationSchema.execute(query, {}).as_json }

  let(:registered_user) { User.first }
  let(:access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImV4cCI6MTU4OTExNzQwMCwiY2xpZW50X3VpZCI6IjEtMTU4OTExMzgwMCIsImp0aSI6InNlSHlTTTN"\
    "kdWE3V0EiLCJ0eXBlIjoiYWNjZXNzIn0.v-Y3cXnNkIGZcmOUV0z1vIXhjtpb4F8J5L2JZvxsD5A"
  end
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImNsaWVudF91aWQiOiIxLTE1ODkxMTM4MDAiLCJleHAiOjE1OTE3MDU4MDAsImp0aSI6InNlSHlTTT" \
    "NkdWE3V0EiLCJ0eXBlIjoicmVmcmVzaCJ9.7gHXHRdGwlhzTnawf2YNW6up3G0-OWdm_GV3-VcwXa0"
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
