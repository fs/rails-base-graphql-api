require "rails_helper"

describe "Authenticate user", type: :request do
  include_context "when time is frozen"

  let!(:user) { create(:user, id: 111_111) }
  let(:query) do
    <<-GRAPHQL
      query {
        me {
          id
        }
      }
    GRAPHQL
  end

  before do
    post "/graphql", headers: { authorization: "Bearer #{token.token}" }, params: { query: query }
  end

  context "with valid token" do
    let(:token) { create(:refresh_token, :access, user: user) }

    it_behaves_like "full graphql request", "return current user" do
      let(:fixture_path) { "json/acceptance/current_user.json" }
    end
  end

  context "with invalid token" do
    let(:token) { create(:refresh_token, token: "bad_token", user: user) }

    it_behaves_like "full graphql request", "return null" do
      let(:fixture_path) { "json/acceptance/not_user.json" }
    end
  end

  context "with expired token" do
    let(:token) { create(:refresh_token, :access, user: user, expires_at: 1.day.ago) }

    it_behaves_like "full graphql request", "return null" do
      let(:fixture_path) { "json/acceptance/not_user.json" }
    end
  end

  context "when use refresh token for receiving user" do
    let(:token) { create(:refresh_token, :refresh, user: user) }

    it_behaves_like "full graphql request", "return null" do
      let(:fixture_path) { "json/acceptance/not_user.json" }
    end
  end
end
