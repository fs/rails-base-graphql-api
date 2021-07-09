require "rails_helper"

describe ConfirmUser do
  describe ".call" do
    include_context "with interactor"
    include_context "when time is frozen"

    let(:user) { create :user, password: "123456" }
    let(:possession_token) { create :possession_token, user: user }
    let(:initial_context) { { user: user, value: possession_token.value } }
    let(:confirmed_at) { Time.current }

    context "with valid data" do
      let(:user_id) { user.id }
      let(:event) { :user_updated }

      it_behaves_like "success interactor"

      it "updates user" do
        interactor.run

        expect(user).to have_attributes(
          confirmed_at: confirmed_at
        )

        expect(PossessionToken.count).to be_zero
      end
    end
  end
end
