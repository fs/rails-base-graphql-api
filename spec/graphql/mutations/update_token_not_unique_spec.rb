require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

  let(:schema_context) { { current_user: user, token: current_refresh_token.token } }
  let(:user) { create(:user, id: 111_111) }
  let(:current_refresh_token) { create(:refresh_token, user: user) }
  let(:existing_token_value) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTkxNzA1ODAwLCJqdGkiOiI3ZmM2ZDIxOTEzODExYmU" \
      "0OGRiNzQ0MTdmOWEyNjU5OCIsInR5cGUiOiJyZWZyZXNoIn0.NcsFRIy6_P5FU4iEm-28hBWRMRDMGn8ei7dKJJfpD_0"
  end

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
    create(:refresh_token, token: existing_token_value)
  end

  it_behaves_like "graphql request", "returns error" do
    let(:fixture_path) { "json/acceptance/graphql/mutations/update_token_invalid.json" }
  end
end
