require "rails_helper"

describe Mutations::RegisterUser do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }

  let!(:user) { create :user, email: "bilbo.baggins@shire.com", password: "TheRing" }

  let(:query) do
    <<-GRAPHQL
      mutation {
        loginUser (
          email: "bilbo.baggins@shire.com",
          password: "TheRing"
        ) {
          user {
            email
          }
          token
        }
      }
    GRAPHQL
  end

  let(:expected_response) do
    {
      "data" => {
        "loginUser" => {
          "user" => {
            "email" => "bilbo.baggins@shire.com"
          },
          "token" => token
        }
      }
    }
  end

  let(:token) { JWT.encode({sub: user.id}, nil, "none") }

  context "with valid credentials" do
    it "gets user token" do
      expect(response).to eq expected_response
    end
  end
end
