require "rails_helper"

describe CreatePossessionToken do
  include_context "with interactor"
  include_context "when time is frozen"

  let(:initial_context) { { user: user } }
  let(:user) { create(:user, id: 111_111) }

  let(:possession_token_length) { 80 }
  let(:saved_possession_token) { PossessionToken.last }

  let(:possession_token_attributes) do
    {
      user_id: 111_111
    }
  end

  describe ".call" do
    it_behaves_like "success interactor"

    it "creates possession token" do
      expect { interactor.run }.to change(PossessionToken, :count).by(1)
      expect(saved_possession_token).to have_attributes(possession_token_attributes)
    end
  end
end
