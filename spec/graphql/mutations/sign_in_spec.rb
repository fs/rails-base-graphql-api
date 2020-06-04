require "rails_helper"

describe Mutations::SignIn do
  include_context "when time is frozen"

  let(:response) { ApplicationSchema.execute(query, {}).as_json }
  let(:query) do
    <<-GRAPHQL
      mutation {
        signin (
          email: "bilbo.baggins@shire.com",
          password: "#{password}"
        ) {
          me {
            id
            email
          }
          refreshToken
          accessToken
        }
      }
    GRAPHQL
  end

  let(:access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJqdGkiOiI3ZmM2ZDIxOTEzODExYmU" \
    "0OGRiNzQ0MTdmOWEyNjU5OCIsInR5cGUiOiJhY2Nlc3MifQ.e-wdSHA4hdSL3NzSrQMzPb1ggFCJDgRW_MGrcXPHwPM"
  end
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTkxNzA1ODAwLCJqdGkiOiI3ZmM2ZDIxOTEzODEx" \
    "YmU0OGRiNzQ0MTdmOWEyNjU5OCIsInR5cGUiOiJyZWZyZXNoIn0.NcsFRIy6_P5FU4iEm-28hBWRMRDMGn8ei7dKJJfpD_0"
  end

  before do
    create :user, id: 111_111, email: "bilbo.baggins@shire.com", password: "TheRing"
  end

  context "with valid credentials" do
    let(:password) { "TheRing" }
    let(:expected_response) do
      {
        "data" => {
          "signin" => {
            "accessToken" => access_token,
            "refreshToken" => refresh_token,
            "me" => {
              "id" => "111111",
              "email" => "bilbo.baggins@shire.com"
            }
          }
        }
      }
    end

    it "gets user token" do
      expect(response).to eq expected_response
    end
  end

  context "with invalid credentials" do
    let(:password) { "Sauron" }
    let(:expected_response) do
      {
        "data" => {
          "signin" => nil
        },
        "errors" => [
          {
            "message" => "Invalid credentials",
            "extensions" => {
              "status" => 401,
              "code" => "unauthorized",
              "detail" => nil
            },
            "locations" => [
              {
                "line" => 2,
                "column" => 9
              }
            ],
            "path" => ["signin"]
          }
        ]
      }
    end

    it "returns error" do
      expect(response).to eq expected_response
    end
  end
end
