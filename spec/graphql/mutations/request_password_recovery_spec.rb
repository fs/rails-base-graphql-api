require "rails_helper"

describe Mutations::RequestPasswordRecovery do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }
  let(:query) do
    <<-GRAPHQL
      mutation {
        requestPasswordRecovery(email: "zaphod.beeblebrox@gmail.com") {
          message
          detail
        }
      }
    GRAPHQL
  end

  let(:fixture_path) { "json/acceptance/graphql/request_password_recovery.json" }

  context "when user exists" do
    let(:user) { create :user, email: "zaphod.beeblebrox@gmail.com" }

    it_behaves_like "graphql request", "returns info message"
  end

  context "when user doesn't exist" do
    let(:user) { build :user }

    it_behaves_like "graphql request", "returns the same info message"
  end
end
