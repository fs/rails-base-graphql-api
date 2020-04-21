require "rails_helper"

describe Mutations::SignIn do
  let!(:user) { create :user, email: "bilbo.baggins@shire.com", password: "TheRing" }

  let(:token) { JWT.encode({ sub: user.id }, nil, "none") }

  context "with valid credentials" do
    let(:response) { ApplicationSchema.execute(query, {}).as_json }

    let(:query) do
      <<-GRAPHQL
        mutation {
          signin (
            email: "bilbo.baggins@shire.com",
            password: "TheRing"
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
    let(:response) { ApplicationSchema.execute(query, {}).as_json }

    let(:query) do
      <<-GRAPHQL
        mutation {
          signin (
            email: "bilbo.baggins@shire.com",
            password: "Sauron"
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

    let(:expected_response) do
      { "data" =>
        { "signin" => nil },
          "errors" => [
          { "message" => "Invalid credentials",
            "locations" => [
              {
                "line" => 2,
                "column" => 11
              }
            ],
            "path" => ["signin"]
          }
        ]
      }
    end

    it "gets errors message" do
      expect(response).to eq expected_response
    end
  end
end
