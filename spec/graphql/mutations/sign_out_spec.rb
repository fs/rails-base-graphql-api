require "rails_helper"

describe Mutations::SignOut, type: :request do
  let(:user) { create(:user) }
  let(:everywhere) { true }
  let(:refresh_token) { create(:refresh_token, user: user) }
  let(:query) do
    <<-GRAPHQL
    mutation {
      signOut(
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

  let(:execution_context) do
    {
      context: {
        current_user: user, token: refresh_token.token, everywhere: everywhere
      }
    }
  end
  let(:schema_context) { { current_user: user } }

  it_behaves_like "graphql request", "return current user" do
    let(:fixture_path) { "json/acceptance/sign_out/success.json" }
  end
end
