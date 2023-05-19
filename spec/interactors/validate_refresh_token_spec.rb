require "rails_helper"

describe ValidateRefreshToken do
  include_context "with interactor"

  let(:initial_context) { { token: token } }
  let(:user) { create(:user, id: 111_111) }

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

      before { create(:refresh_token, token: token, user: user) }

      it_behaves_like "success interactor"

      it "removes refresh token" do
        expect { interactor.run }.to change(RefreshToken, :count).from(1).to(0)
      end

      it "sets context jti" do
        interactor.run

        expect(context.jti).to eq("46d300ea39ab466d79586a856a41ee32")
      end

      it "sets context user" do
        interactor.run

        expect(context.user).to eq(user)
      end
    end
  end
end
