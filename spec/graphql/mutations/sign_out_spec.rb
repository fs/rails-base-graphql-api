require "rails_helper"

describe Mutations::SignOut, type: :request do
  include_context "when time is frozen"

  let(:user) { create :user, id: 111_111 }
  let(:everywhere) { true }
  let(:query) do
    <<-GRAPHQL
    mutation {
      signout(everywhere: #{everywhere})
      {
        id
      }
    }
    GRAPHQL
  end

  before do
    post "/graphql", headers: { authorization: refresh_token.token }, params: { query: query }
  end

  context "with valid token" do
    let(:refresh_token) { create :refresh_token, :access, user: user }

    it_behaves_like "full graphql request", "return current user" do
      let(:fixture_path) { "json/acceptance/signout/current_user.json" }
    end

    context "when everywhere is false" do
      let(:everywhere) { false }

      it_behaves_like "full graphql request", "return current user" do
        let(:fixture_path) { "json/acceptance/signout/current_user.json" }
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
