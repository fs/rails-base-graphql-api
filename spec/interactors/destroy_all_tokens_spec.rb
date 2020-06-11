require "rails_helper"

describe DestroyAllTokens do
  include_context "with interactor"

  let(:initial_context) { { user: user } }
  let(:user) { create :user }

  before do
    create :refresh_token, user: user
  end

  describe ".call" do
    context "with user not update password" do
      it_behaves_like "success interactor"

      it "creates user" do
        interactor.run

        expect(user.refresh_tokens.count).to eq(1)
      end
    end

    context "with user update password" do
      it_behaves_like "success interactor"

      it "creates user" do
        allow(user).to receive(:will_save_change_to_attribute?).and_return(true)

        interactor.run

        expect(user.refresh_tokens.count).to be_zero
      end
    end
  end
end
