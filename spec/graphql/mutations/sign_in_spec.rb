require "rails_helper"

describe Mutations::SignIn do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }
  let(:query) do
    <<-GRAPHQL
      mutation {
        signin (
          email: "bilbo.baggins@shire.com",
          password: "#{password}"
        ) {
          me {
            id
            email
          }
          refreshToken
          accessToken
        }
      }
    GRAPHQL
  end

  let!(:user) { create :user, email: "bilbo.baggins@shire.com", password: "TheRing" }
  let(:access_payload) { { sub: user.id, exp: 1.hour.from_now.to_i } }
  let(:access_token) { JWT.encode(access_payload, ENV["AUTH_SECRET_TOKEN"], "HS256") }
  let(:refresh_payload) { { sub: user.id, client_uid: client_uid, exp: 30.days.from_now.to_i } }
  let(:refresh_token) { JWT.encode(refresh_payload, ENV["AUTH_SECRET_TOKEN"], "HS256") }
  let(:client_uid) { "#{user.id}-qwerty54321" }

  before { allow(SecureRandom).to receive(:hex).and_return("qwerty54321") }

  context "with valid credentials" do
    let(:password) { "TheRing" }
    let(:expected_response) do
      {
        "data" => {
          "signin" => {
            "accessToken" => access_token,
            "refreshToken" => refresh_token,
            "me" => {
              "id" => user.id.to_s,
              "email" => "bilbo.baggins@shire.com"
            }
          }
        }
      }
    end

    it "gets user token" do
      expect(response).to eq expected_response
    end
  end

  context "with invalid credentials" do
    let(:password) { "Sauron" }
    let(:expected_response) do
      {
        "data" => {
          "signin" => nil
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
            "path" => ["signin"]
          }
        ]
      }
    end

    it "returns error" do
      expect(response).to eq expected_response
    end
  end
end
