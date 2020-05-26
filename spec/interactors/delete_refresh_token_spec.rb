require "rails_helper"

describe DeleteRefreshToken do
  include_context "with interactor"

  let(:initial_context) do
    {
      client_uid: client_uid
    }
  end
  let!(:refresh_token) { create :refresh_token, client_uid: "2-dfdfd" }
  let(:user) { create :user }
  let(:error_data) do
    { message: "Not found", status: 404, code: :not_found }
  end

  describe ".call" do
    context "with client_uid" do
      let(:client_uid) { refresh_token.client_uid }

      it "removes refresh token" do
        expect { interactor.run }.to change(RefreshToken, :count).from(1).to(0)
      end
    end

    context "without client_uid" do
      let(:client_uid) { nil }

      it "return error" do
        interactor.run

        expect(context).to be_failure
        expect(context.error_data).to eq(error_data)
      end
    end
  end
end
