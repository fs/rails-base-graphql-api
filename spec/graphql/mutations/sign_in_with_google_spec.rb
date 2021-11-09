require "rails_helper"
require "google/api_client/client_secrets"
require "google/apis/oauth2_v2"

describe Mutations::SignIn do
  include_context "when time is frozen"

  let(:query) do
    <<-GRAPHQL
      mutation {
        signin (
          input: {
            googleAuthCode: "#{auth_code}"
          }
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

  let(:auth_code) { "4/0UDCw-secret_random_string" }

  let(:access_token) { CreateAccessToken.call(user: user).access_token }
  let(:refresh_token) { RefreshToken.last }
  let!(:user) { create :user, :with_data }

  let(:client_secrets_double) { instance_double ::Google::APIClient::ClientSecrets }
  let(:auth_client_double) { instance_double Signet::OAuth2::Client }
  let(:oauth_service_double) { instance_double ::Google::Apis::Oauth2V2::Oauth2Service }
  let(:user_info_double) do
    instance_double ::Google::Apis::Oauth2V2::Userinfo,
                    email: "adam@serwer.com",
                    family_name: "Serwer",
                    given_name: "Adam",
                    hd: "example.com",
                    id: "562193987123901",
                    locale: "ru",
                    name: "Adam Serwer",
                    picture: "https://lh3.googleusercontent.com/a-/HdwuiSKjnjwdd-c-JD7wJwJhdw9x0_JvRc=s32-c",
                    verified_email: true
  end
  let(:google_env_variables) do
    {
      client_id: "google_client_id",
      client_secret: "google_client_secret",
      code: "4/0UDCw-secret_random_string",
      redirect_uri: "postmessage"
    }
  end
  let(:google_access_token) do
    {
      access_token: "access_token",
      expires_in: 3548,
      scope: "https://www.googleapis.com/auth/userinfo.profile",
      token_type: "Bearer",
      id_token: "id_token"
    }.stringify_keys
  end
  let(:get_userinfo_params) { { options: { authorization: auth_client_double } } }

  before do
    allow(::Google::APIClient::ClientSecrets).to receive(:load) { client_secrets_double }
    allow(client_secrets_double).to receive(:to_authorization) { auth_client_double }
    allow(auth_client_double).to receive(:update!).with(google_env_variables) { auth_client_double }
    allow(auth_client_double).to receive(:code=).with(auth_code) { auth_code }
    allow(auth_client_double).to receive(:fetch_access_token!) { google_access_token }
    allow(::Google::Apis::Oauth2V2::Oauth2Service).to receive(:new) { oauth_service_double }
    allow(oauth_service_double).to receive(:get_userinfo).with(get_userinfo_params) { user_info_double }
  end

  context "with valid credentials" do
    it_behaves_like "graphql request", "gets user token" do
      let(:fixture_path) { "json/acceptance/graphql/signin_with_google.json" }
      let(:prepared_fixture_file) do
        fixture_file.gsub(
          /:id|:accessToken|:refreshToken/,
          ":id" => user.id,
          ":accessToken" => access_token,
          ":refreshToken" => refresh_token.token
        )
      end
    end
  end
end
