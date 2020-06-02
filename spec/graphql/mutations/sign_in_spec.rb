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
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlw" \
    "ZSI6ImFjY2VzcyJ9.Dy5NpP_kE4bVDivhiQ0g-vy5yRd-TZpijNt379IMhAI"
  end
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiY2xpZW50X3VpZCI6IjExMTExMS0xNTg5MTEzODAwIiwiZXhwIjoxNTkx" \
    "NzA1ODAwLCJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlwZSI6InJlZnJlc2gifQ.JalYKabh0MJcqFKxJbx0TdLH6PTUN5vjdDkHteuYTPc"
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
