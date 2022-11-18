require "rails_helper"

describe ValidateRefreshToken do
  include_context "with interactor"

  let(:initial_context) do
    {
      token: token,
      token_payload: token_payload
    }
  end
  let(:error_data) do
    { message: "Invalid credentials", status: 401, code: :unauthorized }
  end
  let(:token_payload) { { type: "refresh", jti: "jti" } }

  before do
    create(:refresh_token, jti: "jti")
  end

  describe ".call" do
    context "with valid token" do
      let(:token) { "big_token" }

      it "removes refresh token" do
        expect { interactor.run }.to change(RefreshToken, :count).from(1).to(0)
      end
    end

    context "without token" do
      let(:token) { nil }

      let(:error_data) do
        {
          message: "Invalid credentials",
          status: 401,
          code: :unauthorized
        }
      end

      it_behaves_like "failed interactor"
    end

    context "with two refresh tokens with the same jti" do
      before do
        create(:refresh_token, jti: "jti")
        create(:refresh_token, jti: "other_jti")
      end

      let(:token) { nil }

      it "removes refresh token" do
        expect { interactor.run }.to change(RefreshToken, :count).from(3).to(1)
      end
    end

    context "with access token" do
      let(:token) { "valid_token" }
      let(:token_payload) { { type: "access" } }

      let(:error_data) do
        {
          message: "Invalid credentials",
          status: 401,
          code: :unauthorized
        }
      end

      it_behaves_like "failed interactor"
    end
  end
end
