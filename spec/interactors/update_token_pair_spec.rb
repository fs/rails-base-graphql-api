require "rails_helper"

describe UpdateTokenPair do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { token: refresh_token.token } }
  let(:user) { create(:user, id: 111_111) }
  let!(:refresh_token) do
    create(:refresh_token, user: user,
                           jti: "46d300ea39ab466d79586a856a41ee32",
                           substitution_token: substitution_token)
  end
  let(:substitution_token) { nil }
  let(:created_refresh_token) { RefreshToken.last }

  describe ".call" do
    context "with valid refresh token" do
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
          jti: refresh_token.jti
        )
      end
    end

    context "when refresh token has substitution token" do
      let(:substitution_token) { create(:refresh_token, token: "substitution_token") }

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
