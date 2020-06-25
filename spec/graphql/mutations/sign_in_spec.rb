require "rails_helper"

describe Mutations::SignIn do
  include_context "when time is frozen"

  let(:user_id) { 111_111 }
  let(:query) do
    <<-GRAPHQL
      mutation {
        signin (
          email: "bilbo.baggins@shire.com",
          password: "#{password}"
        ) {
          me {
            id
            email
          }
          refreshToken
          accessToken
        }
      }
    GRAPHQL
  end

  let(:access_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJqdGkiOiI3ZmM2ZDIxOTEzODExYmU" \
    "0OGRiNzQ0MTdmOWEyNjU5OCIsInR5cGUiOiJhY2Nlc3MifQ.e-wdSHA4hdSL3NzSrQMzPb1ggFCJDgRW_MGrcXPHwPM"
  end
  let(:refresh_token) do
    "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTkxNzA1ODAwLCJqdGkiOiI3ZmM2ZDIxOTEzODEx" \
    "YmU0OGRiNzQ0MTdmOWEyNjU5OCIsInR5cGUiOiJyZWZyZXNoIn0.NcsFRIy6_P5FU4iEm-28hBWRMRDMGn8ei7dKJJfpD_0"
  end

  before do
    create :user, id: user_id, email: "bilbo.baggins@shire.com", password: "TheRing"
  end

  context "with valid credentials" do
    let(:password) { "TheRing" }

    it_behaves_like "graphql request", "gets user token" do
      let(:fixture_path) { "json/acceptance/graphql/signin.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:accessToken|:refreshToken/,
          ":accessToken" => access_token,
          ":refreshToken" => refresh_token
        )
      end
    end
  end

  context "with invalid credentials" do
    let(:password) { "Sauron" }
    let(:event) { :user_login_attempt_failed }
    let(:schema_options) do
      {
        context: respond_to?(:schema_context) ? schema_context : {}
      }
    end

    it_behaves_like "graphql request", "returns error" do
      let(:fixture_path) { "json/acceptance/graphql/signin_wrong.json" }
    end

    it "schedules activity job" do
      expect { ApplicationSchema.execute(query, schema_options) }.to have_enqueued_job(RegisterActivityJob)
        .with(user_id, event)
        .on_queue("events")
    end
  end
end
