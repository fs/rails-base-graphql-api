require "rails_helper"

describe Mutations::UpdateUser do
  let(:response) { ApplicationSchema.execute(query, execution_context).as_json }
  let(:execution_context) { { context: { current_user: user } } }
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

  let(:expected_response) do
    {
      "data" => {
        "updateUser" => {
          "id" => user.id.to_s,
          "email" => "new_email_11@example.com",
          "firstName" => "Randle",
          "lastName" => "McMurphy"
        }
      }
    }
  end

  it "returns updated user info" do
    expect(response).to eq(expected_response)
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
