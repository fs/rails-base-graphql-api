require "rails_helper"

describe FindRefreshToken do
  include_context "with interactor"

  let(:initial_context) { { token: jwt_token } }
  let(:user) { create(:user, id: 111_111) }
  let!(:another_refresh_token) { create(:refresh_token, token: "another_token", jti: "jti") }

  let(:error_data) do
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end

  describe ".call" do
    context "with empty token" do
      let(:jwt_token) { nil }

      it_behaves_like "failed interactor"
    end

    context "with invalid token" do
      let(:jwt_token) { "fake_token" }

      it_behaves_like "failed interactor"
    end

    context "with valid access token" do
      let(:access_token) { build(:access_token) }
      let(:jwt_token) { access_token.token }

      it_behaves_like "failed interactor"
    end

    context "with does not persisted valid refresh token" do
      let(:refresh_token) { build(:refresh_token, user: user) }
      let(:jwt_token) { refresh_token.token }

      it_behaves_like "failed interactor"
    end

    context "with persisted valid refresh token" do
      let(:refresh_token) { create(:refresh_token, user: user, substitution_token: substitution_token) }
      let(:jwt_token) { refresh_token.token }
      let(:substitution_token) { nil }

      it_behaves_like "success interactor"

      it "sets context jti" do
        interactor.run

        expect(context.jti).to eq(refresh_token.jti)
      end

      it "sets context user" do
        interactor.run

        expect(context.user).to eq(user)
      end

      it "provides refresh token" do
        interactor.run

        expect(context.existing_refresh_token).to eq(refresh_token)
      end

      context "when refresh token without substituting token" do
        it "does not provide substituting refresh token" do
          interactor.run

          expect(context.substitution_token).to be_nil
        end
      end

      context "when refresh token with substituting token" do
        let(:substitution_token) { another_refresh_token }

        it "provides substituting refresh token" do
          interactor.run

          expect(context.substitution_token).to eq(another_refresh_token)
        end
      end

      context "with valid expired refresh token" do
        let(:refresh_token) { create(:refresh_token, :expired, user: user) }

        it_behaves_like "failed interactor"
      end
    end
  end
end
