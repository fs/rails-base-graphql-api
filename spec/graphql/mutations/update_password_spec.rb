require "rails_helper"

describe Mutations::UpdatePassword do
  include ActiveSupport::Testing::TimeHelpers

  let(:response) { ApplicationSchema.execute(query, {}).as_json }
  let(:user) { create(:user, :with_reset_token) }
  let(:token) { JWT.encode({ sub: user.id }, nil, "none") }
  let(:query) do
    <<-GRAPHQL
      mutation {
        updatePassword(
          password: "new_password",
          resetToken: "#{reset_token}"
        ) {
          token
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

  context "with valid data" do
    let(:reset_token) { user.password_reset_token }

    it_behaves_like "graphql_request", "returns user info" do
      let(:fixture_path) { "json/acceptance/graphql/update_password.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:email|:first_name|:last_name|:token/,
          ":id" => user.id,
          ":email" => user.email,
          ":first_name" => user.first_name,
          ":last_name" => user.last_name,
          ":token" => token
        )
      end
    end
  end

  context "with wrong token" do
    let(:reset_token) { "wrong_token" }

    it_behaves_like "graphql_request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/update_password_wrong.json" }
    end
  end

  context "with expired token" do
    let(:expiration_time) { user.password_reset_sent_at + 15.minutes + 1 }
    let(:reset_token) { user.password_reset_token }

    before do
      travel_to expiration_time
      freeze_time
    end

    after { travel_back }

    it_behaves_like "graphql_request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/update_password_expired.json" }
    end
  end
end
