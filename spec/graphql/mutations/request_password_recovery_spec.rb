require "rails_helper"

describe Mutations::RequestPasswordRecovery do
  let(:query) do
    <<-GRAPHQL
      mutation {
        requestPasswordRecovery(
          input: {
            email: "zaphod.beeblebrox@gmail.com"
          }
        ) {
          message
          detail
        }
      }
    GRAPHQL
  end


  context "when user exists" do
    let!(:user) { create :user, email: "zaphod.beeblebrox@gmail.com" }
    let(:fixture_path) { "json/acceptance/graphql/request_password_recovery.json" }

    it_behaves_like "graphql request", "returns info message"
  end

  context "when user doesn't exist" do
    let!(:user) { build :user }
    let(:fixture_path) { "json/acceptance/graphql/request_password_recovery_wrong.json" }

    it_behaves_like "graphql request", "returns error"
  end
end
