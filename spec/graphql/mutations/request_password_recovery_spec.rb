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
