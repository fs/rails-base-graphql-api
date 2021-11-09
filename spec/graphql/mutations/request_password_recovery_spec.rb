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
    let(:fixture_path) { "json/acceptance/graphql/request_password_recovery.json" }

    before { create :user, email: "zaphod.beeblebrox@gmail.com" }

    it_behaves_like "graphql request", "returns info message"
  end

  context "when user doesn't exist" do
    let(:fixture_path) { "json/acceptance/graphql/request_password_recovery_wrong.json" }

    it_behaves_like "graphql request", "returns error"
  end
end
