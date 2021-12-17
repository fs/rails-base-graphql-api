require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

  let(:schema_context) { { current_user: user, token: token, token_payload: token_payload } }
  let(:user) { create :user, id: 111_111 }
  let(:token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiY2xpZW50X3VpZCI6IjExMTExMS0xNTg5MTEzODAwIiwiZXhwIjoxNT" \
      "kxNzA1ODAwLCJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlwZSI6InJlZnJlc2gifQ.JalYKabh0MJcqFKxJbx0TdLH6PTUN5vjdDkHteuYTPc"
  end
  let(:token_payload) { { type: type } }

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
    create :refresh_token, token: token, user: user
  end

  context "with valid refresh token" do
    let(:type) { "refresh" }

    it_behaves_like "graphql request", "returns updated user token" do
      let(:fixture_path) { "json/acceptance/graphql/update_token.json" }
    end
  end

  context "with valid access token" do
    let(:type) { "access" }

    it_behaves_like "graphql request", "returns failed update token response" do
      let(:fixture_path) { "json/acceptance/graphql/update_token_failed.json" }
    end
  end
end
