require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

  let(:schema_context) { { token: token } }
  let(:user) { create(:user, id: 111_111) }
  let(:token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoyMDAwMDM5NDg3LCJqdGkiOiI0NmQzMDBlYTM5YWI0NjZ" \
      "kNzk1ODZhODU2YTQxZWUzMiIsInR5cGUiOiJyZWZyZXNoIn0.D2gEdqX6koi6G4Q9nwQl8ThkFCqdBJEznDInFBR-py8"
  end

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

  before do
    create(:refresh_token, token: token, user: user)
  end

  it_behaves_like "graphql request", "returns updated user token" do
    let(:fixture_path) { "json/acceptance/graphql/mutations/update_token_valid.json" }
  end
end
