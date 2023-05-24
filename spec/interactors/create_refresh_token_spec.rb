require "rails_helper"

describe CreateRefreshToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { user: user, jti: "jti", substitution_token: substitution_token } }

  let(:user) { create(:user, id: 111_111) }
  let(:refresh_token) { build(:refresh_token, user: user, jti: "jti", expires_at: 30.days.since) }
  let(:created_refresh_token) { RefreshToken.last }
  let(:substitution_token) { nil }

  let(:expected_refresh_token_attributes) do
    {
      user_id: 111_111,
      token: refresh_token.token,
      jti: "jti",
      expires_at: 30.days.since
    }
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "provides generated refresh token" do
      interactor.run

      expect(context.refresh_token).to eq(refresh_token.token)
    end

    it "creates refresh token" do
      expect { interactor.run }.to change(RefreshToken, :count).from(0).to(1)
    end

    it "creates refresh token with correct attributes" do
      interactor.run

      expect(created_refresh_token).to have_attributes(expected_refresh_token_attributes)
    end

    context "when substitution token provided" do
      let(:substitution_token) { create(:refresh_token, user: user, token: "substitution_token_value") }

      it_behaves_like "success interactor"

      it "provides refresh token" do
        interactor.run

        expect(context.refresh_token).to eq("substitution_token_value")
      end

      it "does not create refresh token" do
        interactor.run

        expect(user.refresh_tokens.count).to eq(1)
      end
    end
  end
end
