require "rails_helper"

describe "Authenticate user", type: :request do
  include_context "when time is frozen"
  let(:user) { create :user, id: 111_111 }

  before do
    post "/graphql", headers: { authorization: refresh_token.token }, params: { query: "query { me { id } }" }
  end

  context "with valid token" do
    let(:refresh_token) { create :refresh_token, :access, user: user }

    it "return current_user id" do
      expect(JSON.parse(response.body)["data"]["me"]["id"]).to eq("111111")
    end
  end

  context "with invalid token" do
    let(:refresh_token) { create :refresh_token, token: "bad_token", user: user }

    it "return null" do
      expect(JSON.parse(response.body)["data"]["me"]).to eq(nil)
    end
  end

  context "with expired token" do
    let(:refresh_token) { create :refresh_token, :access, user: user, expires_at: 1.day.ago }

    it "return invalid credential error" do
      expect(JSON.parse(response.body)["errors"][0]["message"]).to eq("Invalid credentials")
    end

    it "returns status code 401" do
      expect(JSON.parse(response.body)["errors"][0]["extensions"]["status"]).to have_http_status("401")
    end
  end

  context "when use refresh token for receiving user" do
    let(:refresh_token) { create :refresh_token, :refresh, user: user }

    it "return null" do
      expect(JSON.parse(response.body)["data"]["me"]).to eq(nil)
    end
  end
end
