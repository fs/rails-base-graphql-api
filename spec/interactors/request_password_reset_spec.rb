require "rails_helper"

describe RequestPasswordReset do
  include_context "with interactor"
  include_context "with mail delivery stubbed"

  let(:initial_context) { { email: user.email } }

  before do
    allow(ApplicationMailer).to receive(:password_recovery).and_return(delivery)
  end

  context "when user exists" do
    let(:user) { create(:user) }
    let(:user_id) { user.id }
    let(:event) { :reset_password_requested }

    it_behaves_like "success interactor"

    it "sends email" do
      expect(ApplicationMailer).to receive(:password_recovery)
      interactor.run
    end

    it_behaves_like "activity source"
  end

  context "when user doesn't exist" do
    let(:user) { build(:user, email: "user@test.it") }
    let(:error_data) { { message: "Record not found", detail: "User with email user@test.it not found" } }

    it_behaves_like "failed interactor"

    it "doesn't send email" do
      expect(ApplicationMailer).not_to receive(:password_recovery)
      interactor.run
    end
  end
end
