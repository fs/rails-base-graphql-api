require "rails_helper"

describe RegisterActivityJob do
  let(:user_id) { 570_242 }

  context "when user exists" do
    let!(:user) { create(:user, id: user_id) }

    it "calls interactor to create activity" do
      expect(CreateUserActivity).to receive(:call!).with(user: user, event: :user_registered)

      described_class.perform_now(user_id, :user_registered)
    end
  end

  context "when user does not exist" do
    it "raises" do
      expect { described_class.perform_now(user_id, :user_registered) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
