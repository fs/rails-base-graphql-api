require "rails_helper"

describe Mutations::SignOut, type: :request do
  let(:user) { create(:user) }
  let(:everywhere) { true }
  let(:token) { "token" }
  let(:refresh_token) { create(:refresh_token, user: user) }
  let(:query) do
    <<-GRAPHQL
    mutation {
      signout(
        input: {
          everywhere: #{everywhere}
        }
      )
      {
        message
      }
    }
    GRAPHQL
  end

  let(:execution_context) { { context: { current_user: user, token: token, everywhere: everywhere } } }
  let(:schema_context) { { current_user: user } }

  it_behaves_like "graphql request", "return current user" do
    let(:fixture_path) { "json/acceptance/signout/success.json" }
  end
end
