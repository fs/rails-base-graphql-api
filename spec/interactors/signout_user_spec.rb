require "rails_helper"

describe SignoutUser do
  include_context "with interactor"

  let(:initial_context) do
    {
      user: user,
      everywhere: everywhere,
      token: "token"
    }
  end
  let(:user) { create(:user) }

  before do
    create(:refresh_token, user: user)
    create(:refresh_token, token: "other", user: user)
  end

  describe ".call" do
    context "with everywhere is false" do
      let(:everywhere) { false }

      it "remove refresh token" do
        interactor.run

        expect(user.refresh_tokens.count).to eq(1)
      end
    end

    context "with everywhere is true" do
      let(:everywhere) { true }

      it "remove all refresh tokens" do
        interactor.run

        expect(user.refresh_tokens.count).to be_zero
      end
    end
  end
end
