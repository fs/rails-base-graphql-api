require "rails_helper"

describe Mutations::UpdateToken do
  include_context "when time is frozen"

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

  let(:user) { create :user, id: 111_111, email: "bilbo.baggins@shire.com", password: "TheRing" }
  let(:client_uid) { old_refresh_token.client_uid }
  let(:old_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiY2xpZW50X3VpZCI6IjExMTExMS0xNTg5MTEzODAwIiwiZXhwIjoxNT" \
    "kxNzA1ODAwLCJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlwZSI6InJlZnJlc2gifQ.JalYKabh0MJcqFKxJbx0TdLH6PTUN5vjdDkHteuYTPc"
  end

  let(:old_refresh_token) do
    create :refresh_token, token: old_token, user: user, client_uid: "111111-qwerty54321"
  end

  let(:access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJjbGllbnRfdWlkIjoiMTExMTExLTE1ODkxMTM4MDAiL"\
    "CJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlwZSI6ImFjY2VzcyJ9.1JWZ-l0tcsnsXT0QDQT08en0OBU9EkR6ly1XL7hQ5dg"
  end
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiY2xpZW50X3VpZCI6IjExMTExMS0xNTg5MTEzODAwIiwiZXhwIjoxNTkxNzA1O"\
    "DAwLCJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlwZSI6InJlZnJlc2gifQ.JalYKabh0MJcqFKxJbx0TdLH6PTUN5vjdDkHteuYTPc"
  end

  let(:execution_context) { { context: { current_user: user, token: old_token, client_uid: client_uid } } }

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

  context "with token type access" do
    let(:old_token) do
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJjbGllbnRfdWlkIjoiMTExMTExLTE1ODkxMTM4MDAiLCJq"\
      "dGkiOiJzZWs0elRBR2tOM09JIiwidHlwZSI6ImFjY2VzcyJ9.1JWZ-l0tcsnsXT0QDQT08en0OBU9EkR6ly1XL7hQ5dg"
    end
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
end
