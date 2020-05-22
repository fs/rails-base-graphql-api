require "rails_helper"

describe Mutations::UpdateToken do
  let(:response) { ApplicationSchema.execute(query, execution_context).as_json }

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

  let(:user) { create :user, email: "bilbo.baggins@shire.com", password: "TheRing" }
  let(:token) { old_refresh_token.token }
  let(:old_refresh_token) { create :refresh_token, token: "old_token", user: user, client_uid: "client_uid" }

  let(:access_payload) { { sub: user.id, exp: 1.hour.from_now.to_i } }
  let(:access_token) { JWT.encode(access_payload, ENV["AUTH_SECRET_TOKEN"], "HS256") }
  let(:refresh_payload) { { sub: user.id, client_uid: client_uid, exp: 30.days.from_now.to_i } }
  let(:refresh_token) { JWT.encode(refresh_payload, ENV["AUTH_SECRET_TOKEN"], "HS256") }
  let(:client_uid) { "#{user.id}-qwerty54321" }

  let(:execution_context) { { context: { current_user: user, refresh_token: token } } }

  before { allow(SecureRandom).to receive(:hex).and_return("qwerty54321") }

  context "with valid credentials" do
    let(:password) { "TheRing" }
    let(:expected_response) do
      {
        "data" => {
          "updateToken" => {
            "accessToken" => access_token,
            "refreshToken" => refresh_token
          }
        }
      }
    end

    it "gets user token" do
      expect(response).to eq expected_response
    end
  end

  context "without user" do
    let(:execution_context) { { context: { current_user: nil, refresh_token: token } } }
    let(:expected_response) do
      {
        "data" => {
          "updateToken" => nil
        },
        "errors" => [
          {
            "message" => "Invalid credentials",
            "extensions" => {
              "status" => 401,
              "code" => "unauthorized",
              "detail" => nil
            },
            "locations" => [
              {
                "line" => 2,
                "column" => 9
              }
            ],
            "path" => ["updateToken"]
          }
        ]
      }
    end

    it "returns error" do
      expect(response).to eq expected_response
    end
  end

  context "without refresh token" do
    let(:token) { nil }
    let(:expected_response) do
      {
        "data" => {
          "updateToken" => nil
        },
        "errors" => [
          {
            "message" => "Not found",
            "extensions" => {
              "status" => 404,
              "code" => "not_found",
              "detail" => nil
            },
            "locations" => [
              {
                "line" => 2,
                "column" => 9
              }
            ],
            "path" => ["updateToken"]
          }
        ]
      }
    end

    it "returns error" do
      expect(response).to eq expected_response
    end
  end
end
