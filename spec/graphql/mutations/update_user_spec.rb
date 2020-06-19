require "rails_helper"

describe Mutations::UpdateUser do
  let(:schema_context) { { current_user: user } }
  let(:user) { create :user, password: "123456" }
  let(:query) do
    <<-GRAPHQL
      mutation {
        updateUser (
          email: "new_email_11@example.com",
          firstName: "Randle",
          lastName: "McMurphy",
          currentPassword: "123456",
          password: "qwerty"
        ) {
          id
          email
          firstName
          lastName
        }
      }
    GRAPHQL
  end

  it_behaves_like "graphql request", "returns updated user info" do
    let(:fixture_path) { "json/acceptance/graphql/update_user.json" }
    let(:prepared_fixture_file) do
      fixture_file.gsub(
        /:id/,
        ":id" => user.id
      )
    end
  end
end
