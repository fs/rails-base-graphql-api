require "rails_helper"

describe Mutations::UpdatePassword do
  include_context "when time is frozen"

  let(:user) do
    create(:user, :with_reset_token, id: 111_111, email: "john.doe@example.com", first_name: "John", last_name: "Doe")
  end

  let(:query) do
    <<-GRAPHQL
      mutation {
        updatePassword(
          input: {
            password: "new_password",
            resetToken: "#{reset_token}"
          }
        ) {
          me {
            id
            email
            firstName
            lastName
          }
          accessToken,
          refreshToken
        }
      }
    GRAPHQL
  end

  context "with valid data" do
    let(:reset_token) { user.password_reset_token }

    it_behaves_like "graphql request", "returns user info" do
      let(:fixture_path) { "json/acceptance/graphql/update_password.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(/:id/, ":id" => user.id)
      end
    end
  end

  context "with wrong token" do
    let(:reset_token) { "wrong_token" }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/update_password_wrong.json" }
    end
  end

  context "with expired token" do
    let(:current_time) { user.password_reset_sent_at + 15.minutes + 1 }
    let(:reset_token) { user.password_reset_token }

    before { freeze_time }

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/update_password_expired.json" }
    end
  end
end
