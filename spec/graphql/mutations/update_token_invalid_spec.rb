require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

  let(:schema_context) { { current_user: user, token: current_refresh_token.token } }
  let(:user) { create(:user) }
  let(:current_refresh_token) { create(:refresh_token, :access, user: user) }

  let(:query) do
    <<-GRAPHQL
      mutation {
        updateToken {
          me {
            id
          }
          accessToken
          refreshToken
        }
      }
    GRAPHQL
  end

  it_behaves_like "graphql request", "returns error" do
    let(:fixture_path) { "json/acceptance/graphql/mutations/update_token_invalid.json" }
  end
end
