require "rails_helper"

describe DeleteRefreshToken do
  include_context "with interactor"

  let(:initial_context) do
    {
      token: token
    }
  end
  let!(:refresh_token) { create :refresh_token, token: "eyJhbGciOiJub25lIn0.eyJkYXRhIjoidGVzdCJ9." }
  let(:user) { create :user }
  let(:error_data) do
    { message: "Not found", status: 404, code: :not_found }
  end

  describe ".call" do
    context "with token" do
      let(:token) { refresh_token.token }

      it "removes refresh token" do
        expect { interactor.run }.to change(RefreshToken, :count).from(1).to(0)
      end
    end

    context "without token" do
      let(:token) { nil }

      it "return error" do
        interactor.run

        expect(context).to be_failure
        expect(context.error_data).to eq(error_data)
      end
    end
  end
end
