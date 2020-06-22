require "rails_helper"

describe UpdatePassword do
  include_context "with interactor"

  let(:user) { create(:user, :with_reset_token) }
  let(:initial_context) { { password: "123456", reset_token: reset_token } }

  context "when token valid" do
    let(:reset_token) { user.password_reset_token }

    it_behaves_like "success interactor"

    it "clears password_reset_* attributes" do
      interactor.run

      expect(user.reload).to have_attributes(
        password_reset_token: nil,
        password_reset_sent_at: nil
      )
    end
  end

  context "when token is wrong" do
    let(:reset_token) { "wrong-token" }
    let(:error_data) do
      {
        message: "Invalid credentials",
        status: 401,
        code: :unauthorized
      }
    end

    it_behaves_like "failed interactor"
  end

  context "when token has expired" do
    let(:expiration_time) { user.password_reset_sent_at + 15.minutes + 1 }
    let(:reset_token) { user.password_reset_token }
    let(:error_data) do
      {
        message: "Record Invalid",
        detail: ["Password reset token has expired"]
      }
    end

    before do
      travel_to expiration_time
      freeze_time
    end

    after { travel_back }

    it_behaves_like "failed interactor"
  end
end
