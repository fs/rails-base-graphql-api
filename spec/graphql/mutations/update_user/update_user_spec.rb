require "rails_helper"

describe Mutations::UpdateUser do
  include_context "when time is frozen"

  let(:schema_context) { { current_user: user } }
  let(:user) { create :user, id: 111_111, password: "123456" }
  let(:query) do
    <<-GRAPHQL
      mutation {
        updateUser (
          email: "new_email_11@example.com",
          firstName: "Randle",
          lastName: "McMurphy"
        ) {
          me {
            id
            email
            firstName
            lastName
          }
          accessToken
          refreshToken
        }
      }
    GRAPHQL
  end

  it_behaves_like "graphql request", "returns updated user info" do
    let(:fixture_path) { "json/acceptance/graphql/update_user.json" }
  end
end
