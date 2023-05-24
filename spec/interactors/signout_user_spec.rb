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
  let(:refresh_token) { create(:refresh_token, user: user) }
  let(:user) { create(:user) }

  before do
    create(:refresh_token, token: "other", user: user)
  end

  describe ".call" do
    context "when everywhere is false" do
      let(:everywhere) { false }

      it "removes refresh token" do
        interactor.run

        expect(user.refresh_tokens.count).to eq(1)
      end
    end

    context "when everywhere is true" do
      let(:everywhere) { true }

      it "removes all refresh tokens" do
        interactor.run

        expect(user.refresh_tokens.count).to be_zero
      end
    end
  end
end
