require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

  let(:schema_context) { { token: current_refresh_token.token } }
  let(:user) { create(:user, id: 111_111) }
  let(:current_refresh_token) { create(:refresh_token, user: user, jti: "46d300ea39ab466d79586a856a41ee32") }
  let(:substitution_token_value) { "13f08fc63d67f72e9818cc66e87a2cf4" }

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
    create(:refresh_token, user: user, token: substitution_token_value, original_token: current_refresh_token)
  end

  it_behaves_like "graphql request", "returns updated user token" do
    let(:fixture_path) { "json/acceptance/graphql/mutations/update_token_existing.json" }
  end
end
