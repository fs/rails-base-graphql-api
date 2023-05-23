require "rails_helper"

describe Mutations::SignIn do
  include_context "when time is frozen"

  let(:query) do
    <<-GRAPHQL
      mutation {
        signIn (
          input: {
            email: "bilbo.baggins@shire.com",
            password: "#{password}"
          }
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

  before do
    create(:user, id: 111_111, email: "bilbo.baggins@shire.com", password: "TheRing")
  end

  context "with valid credentials" do
    let(:password) { "TheRing" }

    it_behaves_like "graphql request", "gets user token" do
      let(:fixture_path) { "json/acceptance/graphql/sign_in.json" }
    end
  end

  context "with invalid credentials" do
    let(:password) { "Sauron" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/sign_in_wrong.json" }
    end
  end
end
