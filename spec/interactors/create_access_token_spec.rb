require "rails_helper"

describe CreateAccessToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { user: user, client_uid: "1-343423523123" } }

  let(:user) { create :user, id: 111_111 }
  let(:expected_access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJqdGkiOiJzZWs0elRBR2tOM09JIiwidHlwZ"\
    "SI6ImFjY2VzcyJ9.Dy5NpP_kE4bVDivhiQ0g-vy5yRd-TZpijNt379IMhAI"
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "generates access token and jti for user" do
      interactor.run

      expect(context.access_token.to_s).to eq(expected_access_token.to_s)
    end
  end
end
