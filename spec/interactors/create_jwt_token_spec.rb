require "rails_helper"

describe CreateJwtToken do
  include_context "with interactor"

  let(:initial_context) { { user: user } }

  let!(:user) { create :user, id: 234_790, email: "user@example.com", password: "password" }

  describe ".call" do
    it_behaves_like "success interactor"

    it "generates jwt token for user" do
      interactor.run

      expect(context.token).to eq("eyJhbGciOiJub25lIn0.eyJzdWIiOjIzNDc5MH0.")
    end
  end
end
