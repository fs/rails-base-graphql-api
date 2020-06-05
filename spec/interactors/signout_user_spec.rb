require "rails_helper"

describe SignoutUser do
  include_context "with interactor"

  let(:initial_context) { { token: token, everywhere: everywhere, token_payload: token_payload } }
  let(:token_payload) { { sub: 111_333 }.stringify_keys }
  let(:user_1) { create :user, id: 111_333 }
  let(:user_2) { create :user, id: 222_222 }
  let(:token) { "token" }
  let(:everywhere) { false }

  describe ".call" do
    before do
      create :refresh_token, user: user_1, token: "token"
      create :refresh_token, user: user_1, token: "other"
      create :refresh_token, user: user_2
    end

    context "with everywhere is true" do
      let(:everywhere) { true }

      it_behaves_like "success interactor"

      it "remove all user tokens" do
        expect { interactor.run }.to change(RefreshToken, :count).from(3).to(1)
      end
    end

    context "with everywhere is false" do
      it_behaves_like "success interactor"

      it "remove one user token" do
        expect { interactor.run }.to change(RefreshToken, :count).from(3).to(2)
      end
    end

    context "with token is deleted" do
      let(:token) { "deleted" }
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
