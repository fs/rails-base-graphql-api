require "rails_helper"

describe RegisterActivityJob do
  let(:user_id) { 570_242 }

  context "when user exists" do
    let!(:user) { create :user, id: user_id }

    it "calls interactor to create activity" do
      expect(CreateRegisterActivity).to receive(:call!).with(user: user)

      described_class.perform_now(user_id)
    end
  end

  context "when user does not exist" do
    it "raises" do
      expect { described_class.perform_now(user_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
