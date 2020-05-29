require "rails_helper"

describe CreateAccessToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { user: user, client_uid: "1-343423523123" } }

  let(:user) { create :user, id: 111_111 }
  let(:expected_access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJjbGllbnRfdWlkIjoiMTExMTExLTE1ODkxMTM4"\
    "MDAiLCJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlwZSI6ImFjY2VzcyJ9.1JWZ-l0tcsnsXT0QDQT08en0OBU9EkR6ly1XL7hQ5dg"
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "generates access token and jti for user" do
      interactor.run

      expect(context.access_token.to_s).to eq(expected_access_token.to_s)
    end
  end
end
