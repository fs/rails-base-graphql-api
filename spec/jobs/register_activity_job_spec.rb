require "rails_helper"

describe RegisterActivityJob do
  include ActiveJob::TestHelper

  let!(:user) { create :user }

  context "when user exists" do
    it "calls interactor to create activity" do
      expect(CreateRegisterActivity).to receive(:call).with(user: user)

      described_class.perform_now(user.id)
    end
  end

  context "when user does not exist" do
    it "interactor will not create activity" do
      expect(CreateRegisterActivity).not_to receive(:call)

      described_class.perform_now(777)
    end
  end
end
