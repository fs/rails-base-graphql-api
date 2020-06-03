require "rails_helper"

describe ExistingPasswordValidator do
  let(:form) { UpdateUserForm.new(user) }
  let(:user) { build(:user, password: "123456") }

  before do
    form.assign_attributes({ password: "qwerty", current_password: current_password })
    form.validate
  end

  describe "existing password valiadation" do
    context "when current_password is invalid" do
      let(:current_password) { "1234_56" }

      it "fails and adds error" do
        expect(form.errors[:current_password]).to include("is incorrect")
      end
    end

    context "when current_password is valid" do
      let(:current_password) { "123456" }

      it "succeeds" do
        expect(form.errors).to be_empty
      end
    end
  end
end
