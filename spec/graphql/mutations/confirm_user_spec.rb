require "rails_helper"

describe Mutations::ConfirmUser do
  include_context "when time is frozen"

  let(:schema_context) { { current_user: user } }
  let(:user) { create(:user, id: 123_456, password: "123456") }
  let(:possession_token) { create(:possession_token, user: user) }

  let(:query) do
    <<-GRAPHQL
      mutation {
        confirmUser (
          input: {
            value: "#{possession_token.value}"
          }
        ) {
          me {
            id
            confirmedAt
          }
        }
      }
    GRAPHQL
  end

  it_behaves_like "graphql request", "returns updated user info" do
    let(:fixture_path) { "json/acceptance/graphql/confirm_user.json" }
  end
end
