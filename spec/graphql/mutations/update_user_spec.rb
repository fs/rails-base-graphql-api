require "rails_helper"

describe Mutations::UpdateUser do
  let(:response) { ApplicationSchema.execute(query, execution_context).as_json }
  let(:execution_context) { { context: schema_context } }
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
          me {
            id
            email
            firstName
            lastName
          }
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

  it "updates user" do
    response

    expect(user).to have_attributes(
      email: "new_email_11@example.com",
      first_name: "Randle",
      last_name: "McMurphy"
    )
  end
end
