require "rails_helper"

describe ExpirationValidator do
  include_context "when time is frozen"

  let(:form) { UpdateUserPasswordForm.new(user) }
  let(:user) { build(:user, :with_reset_token) }
  let(:expiration_time) { user.password_reset_sent_at + 15.minutes }

  before do
    form.assign_attributes({ password: "qwerty" })
    form.validate
  end

  describe "active reset token validation" do
    context "when reset token is invalid" do
      let(:current_time) { expiration_time + 1 }

      it "fails and adds error" do
        expect(form.errors[:password_reset_sent_at]).to include("has expired")
      end
    end

    context "when reset token is valid" do
      let(:current_time) { expiration_time }

      it "succeeds" do
        expect(form.errors).to be_empty
      end
    end
  end
end
