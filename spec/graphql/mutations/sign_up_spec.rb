require "rails_helper"

describe Mutations::SignUp do
  include_context "when time is frozen"

  before do
    allow(JWT).to receive(:encode).and_return("jwt.token.success")
  end

  let(:registered_user) { User.last }

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
          accessToken
          refreshToken
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    let(:email) { "bilbo.baggins@shire.com" }

    it_behaves_like "graphql request", "registers a new user" do
      let(:fixture_path) { "json/acceptance/graphql/signup.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:accessToken|:refreshToken/,
          ":id" => registered_user.id,
          ":accessToken" => "jwt.token.success",
          ":refreshToken" => "jwt.token.success"
        )
      end
    end
  end

  context "with invalid data" do
    let(:email) { "bilbo.baggins" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/signup_wrong.json" }
    end
  end
end
