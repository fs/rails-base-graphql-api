require "rails_helper"

describe Mutations::SignIn do
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

    it_behaves_like "graphql request", "gets user token" do
      let(:fixture_path) { "json/acceptance/graphql/signin.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:token/,
          ":id" => user.id,
          ":token" => token
        )
      end
    end
  end

  context "with invalid credentials" do
    let(:password) { "Sauron" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/signin_wrong.json" }
    end
  end
end
