require "rails_helper"

describe Mutations::UpdatePassword do
  include ActiveSupport::Testing::TimeHelpers

  let(:response) { ApplicationSchema.execute(query, {}).as_json }
  let(:user) { create(:user, :with_reset_token) }
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
        }
      }
    GRAPHQL
  end

  let(:expected_response) do
    {
      "data" => {
        "updatePassword" => {
          "me" => {
            "id" => user.id.to_s,
            "email" => user.email,
            "firstName" => user.first_name,
            "lastName" => user.last_name
          }
        }
      }
    }
  end

  context "with valid data" do
    let(:reset_token) { user.password_reset_token }

    it "returns user info" do
      expect(response).to eq(expected_response)
    end
  end

  context "with wrong token" do
    let(:reset_token) { "wrong_token" }
    let(:expected_response) do
      {
        "data" => {
          "updatePassword" => nil
        },
        "errors" => [
          {
            "message" => "Invalid credentials",
            "extensions" => {
              "status" => 401,
              "code" => "unauthorized",
              "detail" => nil
            },
            "locations" => [
              {
                "line" => 2,
                "column" => 9
              }
            ],
            "path" => ["updatePassword"]
          }
        ]
      }
    end

    it "returns error" do
      expect(response).to eq expected_response
    end
  end

  context "with expired token" do
    let(:expiration_time) { user.password_reset_sent_at + 901.seconds } # 15 minutes + 1 second
    let(:reset_token) { user.password_reset_token }
    let(:expected_response) do
      {
        "data" => {
          "updatePassword" => nil
        },
        "errors" => [
          {
            "message" => "Record Invalid",
            "extensions" => {
              "status" => 422,
              "code" => "unprocessable_entity",
              "detail" => ["Password reset token has expired"]
            },
            "locations" => [
              {
                "line" => 2,
                "column" => 9
              }
            ],
            "path" => ["updatePassword"]
          }
        ]
      }
    end

    before do
      travel_to expiration_time
      freeze_time
    end

    after { travel_back }

    it "returns error" do
      expect(response).to eq expected_response
    end
  end
end
