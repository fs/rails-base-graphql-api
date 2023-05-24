require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

  let(:schema_context) { { token: refresh_token.token } }
  let(:user) { create(:user, id: 111_111) }
  let(:refresh_token) { create(:refresh_token, user: user, jti: "46d300ea39ab466d79586a856a41ee32") }

  let(:query) do
    <<-GRAPHQL
      mutation{
        updateToken {
          accessToken
          refreshToken
        }
      }
    GRAPHQL
  end

  it_behaves_like "graphql request", "returns updated user token" do
    let(:fixture_path) { "json/acceptance/graphql/mutations/update_token_valid.json" }
  end
end
