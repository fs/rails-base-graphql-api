<<<<<<< HEAD
require "rails_helper"

describe Mutations::RequestPasswordRecovery do
  let(:response) { ApplicationSchema.execute(query, {}).as_json }
  let(:user) { create :user }
  let(:query) do
    <<-GRAPHQL
      mutation {
        requestPasswordRecovery(email: "#{user.email}") {
          message
          detail
        }
      }
    GRAPHQL
  end

  let(:expected_response) do
    {
      "data" => {
        "requestPasswordRecovery" => {
          "message" => "Instructions sent",
          "detail" => "Password recovery instructions were sent if that account exists"
        }
      }
    }
  end

  it "invokes interactor" do
    expect(RequestPasswordReset).to receive(:call)
    response
  end

  context "when user exists" do
    it "returns info message" do
      expect(response).to eq(expected_response)
    end
  end

  context "when user doesn't exist" do
    let(:user) { build :user }

    it "returns the same info message" do
      expect(response).to eq(expected_response)
    end
  end
end
||||||| 858544b
=======
require "rails_helper"

describe Mutations::RequestPasswordRecovery do
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
>>>>>>> master
