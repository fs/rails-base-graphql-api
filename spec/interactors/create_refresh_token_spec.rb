require "rails_helper"

describe CreateRefreshToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { user: user, jti: jti } }

  let(:user) { create :user, id: 111_111 }
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTkxNzA1ODAwLCJqdGkiOiJqdG"\
      "kiLCJ0eXBlIjoicmVmcmVzaCJ9.rLewPTwiODP_ZkGvSN7h_WHGC1xv2DC7r_ne-cggcVo"
  end
  let(:saved_refresh_token) { RefreshToken.last }
  let(:jti) { "jti" }
  let(:expires_at) { 30.days.since }

  let(:refresh_token_attributes) do
    {
      user_id: 111_111,
      token: refresh_token,
      jti: jti,
      expires_at: expires_at
    }
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "provides generated refresh token" do
      interactor.run

      expect(context.refresh_token).to eq(refresh_token)
    end

    it "creates refresh token" do
      interactor.run

      expect(RefreshToken.count).to eq(1)
      expect(saved_refresh_token).to have_attributes(refresh_token_attributes)
    end
  end
end
