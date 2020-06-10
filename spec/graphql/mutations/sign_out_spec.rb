require "rails_helper"

describe Mutations::SignOut, type: :request do
  include_context "when time is frozen"

  let(:user) { create :user, id: 111_111 }
  let(:everywhere) { true }
  let(:refresh_token) { create :refresh_token, :access, user: user }
  let(:query) do
    <<-GRAPHQL
    mutation {
      signout(everywhere: #{everywhere})
      {
        message
      }
    }
    GRAPHQL
  end

  before do
    create :refresh_token, user: user
    post "/graphql", headers: { authorization: refresh_token.token }, params: { query: query }
  end

  context "with valid token" do
    it "destroy all tokens" do
      expect(RefreshToken.count).to eq(0)
    end

    it_behaves_like "full graphql request", "return current user" do
      let(:fixture_path) { "json/acceptance/signout/current_user.json" }
    end

    context "with everywhere is false" do
      let(:everywhere) { false }

      it "destroy one token" do
        expect(RefreshToken.count).to eq(1)
      end
    end
  end

  context "with use deleted refresh token" do
    let(:refresh_token) { create :refresh_token, token: "deleted", user: user }

    it_behaves_like "full graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/signout/null.json" }
    end
  end
end
