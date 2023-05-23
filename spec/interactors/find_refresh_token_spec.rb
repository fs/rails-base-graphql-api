require "rails_helper"

describe FindRefreshToken do
  include_context "with interactor"

  let(:initial_context) { { token: token } }
  let(:user) { create(:user, id: 111_111) }
  let!(:another_refresh_token) { create(:refresh_token, token: "another_token", jti: "jti") }

  let(:error_data) do
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end

  describe ".call" do
    context "with empty token" do
      let(:token) { nil }

      it_behaves_like "failed interactor"
    end

    context "with invalid token" do
      let(:token) { "fake_token" }

      it_behaves_like "failed interactor"
    end

    context "with valid access token" do
      let(:token) do
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoyMDAwMDM5NTA5LCJqdGkiOiIxZGY5NzQ5MjY2ZDdmNzE3Z" \
          "mI4N2E1YzY1ZTVhNDYxNyIsInR5cGUiOiJhY2Nlc3MifQ.n9lw1Ob0IUQhoUrLpF6Oj2bEJQs6c_05Ql64DR-yjos"
      end

      it_behaves_like "failed interactor"
    end

    context "with does not persisted valid refresh token" do
      let(:token) do
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoyMDAwMDM5NDg3LCJqdGkiOiI0NmQzMDBlYTM5YWI0NjZkNz" \
          "k1ODZhODU2YTQxZWUzMiIsInR5cGUiOiJyZWZyZXNoIn0.D2gEdqX6koi6G4Q9nwQl8ThkFCqdBJEznDInFBR-py8"
      end

      it_behaves_like "failed interactor"
    end

    context "with persisted valid refresh token" do
      let(:token) do
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoyMDAwMDM5NDg3LCJqdGkiOiI0NmQzMDBlYTM5YWI0NjZkNz" \
          "k1ODZhODU2YTQxZWUzMiIsInR5cGUiOiJyZWZyZXNoIn0.D2gEdqX6koi6G4Q9nwQl8ThkFCqdBJEznDInFBR-py8"
      end
      let!(:refresh_token) { create(:refresh_token, token: token, user: user) }

      it_behaves_like "success interactor"

      it "sets context jti" do
        interactor.run

        expect(context.jti).to eq("46d300ea39ab466d79586a856a41ee32")
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
        let!(:refresh_token) do
          create(:refresh_token, token: token, jti: "jti", substitution_token: another_refresh_token)
        end

        it "provides substituting refresh token" do
          interactor.run

          expect(context.substitution_token).to eq(another_refresh_token)
        end
      end
    end
  end
end
