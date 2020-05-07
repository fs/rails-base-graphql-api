require "rails_helper"

describe Mutations::SignUp do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }

  let(:registered_user) { User.first }
  let(:token) { JWT.encode({ sub: registered_user.id }, nil, "none") }

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
          token
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
            "token" => token
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
