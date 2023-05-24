require "rails_helper"

describe "Authenticate user", type: :request do
  include_context "when time is frozen"

  let!(:user) { create(:user, id: 111_111) }
  let(:refresh_token) { nil }
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
    refresh_token
    post "/graphql", headers: { authorization: "Bearer #{token.token}" }, params: { query: query }
  end

  context "with valid token and valid refresh token" do
    let(:token) { build(:access_token, user_id: user.id) }
    let(:refresh_token) { create(:refresh_token, user: user, jti: token.jti) }

    it_behaves_like "full graphql request", "return current user" do
      let(:fixture_path) { "json/acceptance/current_user.json" }
    end
  end

  context "with valid token and expired refresh token" do
    let(:token) { build(:access_token, user_id: user.id) }
    let(:refresh_token) { create(:refresh_token, :expired, user: user, jti: token.jti) }

    it_behaves_like "full graphql request", "return null" do
      let(:fixture_path) { "json/acceptance/not_user.json" }
    end
  end

  context "with valid token and without refresh token" do
    let(:token) { build(:access_token, user_id: user.id) }

    it_behaves_like "full graphql request", "return null" do
      let(:fixture_path) { "json/acceptance/not_user.json" }
    end
  end

  context "with invalid token" do
    let(:token) { build(:access_token, :invalid, user_id: user.id) }

    it_behaves_like "full graphql request", "return null" do
      let(:fixture_path) { "json/acceptance/not_user.json" }
    end
  end

  context "with expired token" do
    let(:token) { build(:access_token, :expired, user_id: user.id) }

    it_behaves_like "full graphql request", "return null" do
      let(:fixture_path) { "json/acceptance/not_user.json" }
    end
  end

  context "when use refresh token for receiving user" do
    let(:token) { build(:refresh_token, user: user) }

    it_behaves_like "full graphql request", "return null" do
      let(:fixture_path) { "json/acceptance/not_user.json" }
    end
  end
end
