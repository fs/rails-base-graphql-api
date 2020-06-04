require "rails_helper"

describe Mutations::SignUp do
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

    it_behaves_like "graphql_request", "registers a new user" do
      let(:fixture_path) { "json/acceptance/graphql/signup.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:token/,
          ":id" => registered_user.id,
          ":token" => token
        )
      end
    end
  end

  context "with invalid data" do
    let(:email) { "bilbo.baggins" }

    it_behaves_like "graphql_request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/signup_wrong.json" }
    end
  end
end
