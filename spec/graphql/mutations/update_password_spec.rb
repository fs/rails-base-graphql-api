require "rails_helper"

describe Mutations::UpdatePassword do
  include_context "when time is frozen"

  let(:user) { create(:user, :with_reset_token, email: "john.doe@example.com", first_name: "John", last_name: "Doe") }
  let(:query) do
    <<-GRAPHQL
      mutation {
        updatePassword(
          password: "new_password",
          resetToken: "#{reset_token}"
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
    let(:access_token) do
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMsImV4cCI6MTU4OTExNzQwMCwianRpIjoiNzQwM2UxMjdiNGM0NWFhMjc2" \
      "NDgzMDY1NmY0Zjg4OGYiLCJ0eXBlIjoiYWNjZXNzIn0.xgWQwhcZaU1b5GvQZI6LwhCghteBjh5s3nBB0wJNMac"
    end
    let(:refresh_token) do
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMsImV4cCI6MTU5MTcwNTgwMCwianRpIjoiNzQwM2UxMjdiNGM0NWFhMjc2" \
      "NDgzMDY1NmY0Zjg4OGYiLCJ0eXBlIjoicmVmcmVzaCJ9.c1F6_O4SuXCHRbRcAMGcspTiN0gxSGE0dDMCZ79oh10"
    end

    it_behaves_like "graphql request", "returns user info" do
      let(:fixture_path) { "json/acceptance/graphql/update_password.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:accessToken|:refreshToken/,
          ":id" => user.id,
          ":accessToken" => access_token,
          ":refreshToken" => refresh_token
        )
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
