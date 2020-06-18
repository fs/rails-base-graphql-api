require "rails_helper"

describe ApplicationMailer do
  describe "#password_recovery" do
    subject(:email) { described_class.password_recovery(user) }

    let(:user) { build(:user, password_reset_token: "1234") }

    it { is_expected.to deliver_to(user.email) }

    it "delivers the token" do
      expect(email.html).to include(user.password_reset_token)
    end
  end
end
