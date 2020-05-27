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
          oldPassword: "123456",
          newPassword: "qwerty"
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

  let(:expected_response) do
    {
      "data" => {
        "updateUser" => {
          "me" => {
            "id" => user.id.to_s,
            "email" => "new_email_11@example.com",
            "firstName" => "Randle",
            "lastName" => "McMurphy"
          }
        }
      }
    }
  end

  it "returns updated user info" do
    expect(response).to eq(expected_response)
  end

  it "updates user" do
    response

    expect(user.email).to eq("new_email_11@example.com")
    expect(user.first_name).to eq("Randle")
    expect(user.last_name).to eq("McMurphy")
  end
end
