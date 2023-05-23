require "rails_helper"

describe UpdateTokenPair do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { token: token } }
  let(:user) { create(:user, id: 111_111) }
  let(:token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoyMDAwMDM5NDg3LCJqdGkiOiI0NmQzMDBlYTM5YWI0NjZ" \
      "kNzk1ODZhODU2YTQxZWUzMiIsInR5cGUiOiJyZWZyZXNoIn0.D2gEdqX6koi6G4Q9nwQl8ThkFCqdBJEznDInFBR-py8"
  end
  let(:refresh_token_jti) { "46d300ea39ab466d79586a856a41ee32" }
  let(:created_refresh_token) { RefreshToken.last }

  describe ".call" do
    context "with valid refresh token" do
      before do
        create(:refresh_token, :refresh, token: token, user: user)
      end

      it_behaves_like "success interactor"

      it "creates new access token" do
        interactor.run

        expect(context.access_token).to be_present
      end

      it "creates new refresh token" do
        expect { interactor.run }.to change(RefreshToken, :count).by(1)
      end

      it "creates refresh token with correct attributes" do
        interactor.run

        expect(created_refresh_token).to have_attributes(
          user_id: user.id,
          expires_at: 30.days.from_now,
          jti: refresh_token_jti
        )
      end
    end

    context "when refresh token has substitution token" do
      before do
        substitution_token = create(:refresh_token, token: "substitution_token")
        create(:refresh_token, token: token, jti: refresh_token_jti, user: user,
                               substitution_token: substitution_token)
      end

      it_behaves_like "success interactor"

      it "creates new access token" do
        interactor.run

        expect(context.access_token).to be_present
      end

      it "provides substitution token as a new refresh token" do
        interactor.run

        expect(context.refresh_token).to eq("substitution_token")
      end

      it "does not create new refresh token" do
        expect { interactor.run }.not_to change(RefreshToken, :count)
      end
    end
  end
end
