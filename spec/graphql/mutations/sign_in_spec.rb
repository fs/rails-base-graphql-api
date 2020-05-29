require "rails_helper"

describe Mutations::SignIn do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }
  let(:query) do
    <<-GRAPHQL
      mutation {
        signin (
          email: "bilbo.baggins@shire.com",
          password: "#{password}"
        ) {
          token
          me {
            id
            email
          }
        }
      }
    GRAPHQL
  end

  let!(:user) { create :user, email: "bilbo.baggins@shire.com", password: "TheRing" }
  let(:token) { JWT.encode({ sub: user.id }, nil, "none") }

  context "with valid credentials" do
    let(:password) { "TheRing" }
    let(:expected_response) do
      {
        "data" => {
          "signin" => {
            "token" => token,
            "me" => {
              "id" => user.id.to_s,
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
