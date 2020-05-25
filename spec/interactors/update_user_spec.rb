require "rails_helper"

describe UpdateUser do
  include_context "with interactor"

  describe ".call" do
    let(:user) { create :user }
    let(:user_params) { { first_name: "Arthur", last_name: "Dent" } }
    let(:initial_context) { { user: user, user_params: user_params } }

    it_behaves_like "success interactor"

    it "updates user" do
      interactor.run

      expect(user.first_name).to eq("Arthur")
      expect(user.last_name).to eq("Dent")
    end
  end
end
