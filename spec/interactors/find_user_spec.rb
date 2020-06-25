require "rails_helper"

describe FindUser do
  include_context "with interactor"

  let(:initial_context) do
    { email: email }
  end

  let!(:user) { create :user, email: "user@example.com", password: "password" }

  describe ".call" do
    context "with valid credentials" do
      let(:email) { "user@example.com" }

      it_behaves_like "success interactor"

      it "provides user instance" do
        interactor.run

        expect(context.user).to eq(user)
      end
    end

    context "with invalid credentials" do
      let(:email) { "wrong_user@example.com" }
      let(:error_data) { nil }

      it_behaves_like "failed interactor"
    end
  end
end
