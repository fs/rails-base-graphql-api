require "rails_helper"

RSpec.describe Mutations::RegisterUser do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }

  let(:query) do
    <<-GRAPHQL
      mutation {
        registerUser(
          email: "bilbo.baggins@shire.com",
          firstName: "Bilbo",
          lastName: "Baggins",
          password: "TheRing"
        ) {
          user {
            email
            firstName
            lastName
          }
          errors
        }
      }
    GRAPHQL
  end

  let(:expected_response) do
    { "data" =>
      { "registerUser" =>
        { "user" =>
          { "email"=>"bilbo.baggins@shire.com",
            "firstName"=>"Bilbo",
            "lastName"=>"Baggins"
          },
          "errors" => []
        }
      }
    }
  end

  context "with valid credentials" do
    it "registers new user" do
      expect(response).to eq expected_response
    end
  end
end
