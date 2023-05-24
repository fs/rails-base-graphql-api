require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

  let(:schema_context) { { current_user: user, token: current_refresh_token.token } }
  let(:user) { create(:user, id: 111_111) }
  let(:current_refresh_token) { create(:refresh_token, user: user) }

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

  before do
    create(:refresh_token, user: user, jti: current_refresh_token.jti, expires_at: 30.days.since)
  end

  it_behaves_like "graphql request", "returns error" do
    let(:fixture_path) { "json/acceptance/graphql/mutations/update_token_invalid.json" }
  end
end
