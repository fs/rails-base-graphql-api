require "rails_helper"

describe CreateRefreshToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { user: user, client_uid: client_uid, jti: jti } }

  let(:user) { create :user, id: 111_111 }
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiY2xpZW50X3VpZCI6IjExMTExMS0xMjM0NTY3OCIsImV4cCI6MTU5MTcwNTgw"\
    "MCwianRpIjoianRpIiwidHlwZSI6InJlZnJlc2gifQ.B0aKNaW_ppj2oi6BT66AkKmlz-vaXAPaw7ORJDq9CiU"
  end
  let(:saved_refresh_token) { RefreshToken.last }
  let(:jti) { "jti" }
  let(:expires_at) { 30.days.since }

  let(:refresh_token_attributes) do
    {
      user_id: 111_111,
      token: refresh_token,
      client_uid: client_uid,
      jti: jti,
      expires_at: expires_at
    }
  end
  let(:client_uid) { "111111-12345678" }

  describe ".call" do
    it_behaves_like "success interactor"

    it "generates refresh token for user" do
      interactor.run

      expect(context.refresh_token).to eq(refresh_token)
      expect(RefreshToken.count).to eq(1)
      expect(saved_refresh_token.reload).to have_attributes(refresh_token_attributes)
    end
  end
end
