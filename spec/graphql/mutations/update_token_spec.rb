require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

  let(:schema_context) { { token: token } }
  let(:user) { create(:user, id: 111_111) }

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

  context "with valid refresh token" do
    let(:token) do
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoyMDAwMDM5NDg3LCJqdGkiOiI0NmQzMDBlYTM5YWI0NjZ" \
        "kNzk1ODZhODU2YTQxZWUzMiIsInR5cGUiOiJyZWZyZXNoIn0.D2gEdqX6koi6G4Q9nwQl8ThkFCqdBJEznDInFBR-py8"
    end

    it_behaves_like "graphql request", "returns updated user token" do
      let(:fixture_path) { "json/acceptance/graphql/update_token.json" }
    end
  end

  context "with valid access token" do
    let(:token) do
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoyMDAwMDM5NTA5LCJqdGkiOiIxZGY5NzQ5MjY2ZDdmNzE3Z" \
        "mI4N2E1YzY1ZTVhNDYxNyIsInR5cGUiOiJhY2Nlc3MifQ.n9lw1Ob0IUQhoUrLpF6Oj2bEJQs6c_05Ql64DR-yjos"
    end

    it_behaves_like "graphql request", "returns failed update token response" do
      let(:fixture_path) { "json/acceptance/graphql/update_token_failed.json" }
    end
  end
end
