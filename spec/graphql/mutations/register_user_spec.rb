require "rails_helper"

describe Mutations::RegisterUser do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }

  let(:query) do
    <<-GRAPHQL
      mutation {
        registerUser(
          email: "bilbo.baggins@shire.com",
          password: "TheRing"
        ) {
          user {
            id
            email
          }
        }
      }
    GRAPHQL
  end

  let(:registered_user) { User.first }

  let(:expected_response) do
    { "data" =>
      { "registerUser" =>
        { "user" =>
          { "id" => registered_user.id.to_s,
            "email"=>"bilbo.baggins@shire.com"
          }
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
