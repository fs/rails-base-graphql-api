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

  let(:user) { create :user, id: 111_111 }
  let(:old_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiY2xpZW50X3VpZCI6IjExMTExMS0xNTg5MTEzODAwIiwiZXhwIjoxNT" \
    "kxNzA1ODAwLCJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlwZSI6InJlZnJlc2gifQ.JalYKabh0MJcqFKxJbx0TdLH6PTUN5vjdDkHteuYTPc"
  end

  let(:old_refresh_token) do
    create :refresh_token, token: old_token, user: user, jti: "jti"
  end

  let(:access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJqdGkiOiI3ZmM2ZDIxOTEzODExYmU0OGRiN"\
    "zQ0MTdmOWEyNjU5OCIsInR5cGUiOiJhY2Nlc3MifQ.e-wdSHA4hdSL3NzSrQMzPb1ggFCJDgRW_MGrcXPHwPM"
  end
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTkxNzA1ODAwLCJqdGkiOiI3ZmM2ZDIxOTEzO"\
    "DExYmU0OGRiNzQ0MTdmOWEyNjU5OCIsInR5cGUiOiJyZWZyZXNoIn0.NcsFRIy6_P5FU4iEm-28hBWRMRDMGn8ei7dKJJfpD_0"
  end

  let(:execution_context) { { context: { current_user: user, token: old_token, token_payload: token_payload } } }
  let(:token_payload) { { type: type }.stringify_keys }
  let(:type) { "refresh" }

  before do
    create :refresh_token, token: old_token
  end

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
    let(:type) { "access" }
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
