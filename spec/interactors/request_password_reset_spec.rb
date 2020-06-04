require "rails_helper"

describe RequestPasswordReset do
  include_context "with interactor"

  let(:initial_context) { { email: user.email } }

  before do
    delivery = instance_double(ActionMailer::MessageDelivery)
    allow(delivery).to receive(:deliver_later)
    allow(ApplicationMailer).to receive(:password_recovery).and_return(delivery)
  end

  context "when user exists" do
    let(:user) { create :user }

    it "does send email" do
      expect(ApplicationMailer).to receive(:password_recovery)
      interactor.run
    end
  end

  context "when user doesn't exist" do
    let(:user) { build :user }

    it "doesn't send email" do
      expect(ApplicationMailer).not_to receive(:password_recovery)
      response
    end
  end
end
