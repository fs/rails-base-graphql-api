require "rails_helper"

describe Omniauth::Google::BuildAuthClient do
  subject(:context) { described_class.call(auth_code: auth_code) }

  let(:expected_attributes) do
    {
      access_token: nil,
      access_type: :offline,
      additional_parameters: {},
      authorization_uri: instance_of(Addressable::URI),
      client_id: "google_client_id",
      client_secret: "google_client_secret",
      code: "random_authorization_code",
      expires_at: nil,
      expiry: 60,
      extension_parameters: {},
      id_token: nil,
      issued_at: nil,
      issuer: nil,
      password: nil,
      principal: nil,
      redirect_uri: instance_of(Addressable::URI),
      refresh_token: nil,
      scope: nil,
      state: nil,
      target_audience: nil,
      token_credential_uri: instance_of(Addressable::URI),
      username: nil
    }
  end
  let(:expected_authorization_uri) do
    "https://accounts.google.com/o/oauth2/auth?" \
      "access_type=offline&" \
      "client_id=google_client_id&" \
      "redirect_uri=postmessage&" \
      "response_type=code"
  end
  let(:expected_redirect_uri) { "postmessage" }
  let(:expected_token_credential_uri) { "https://oauth2.googleapis.com/token" }
  let(:auth_code) { "random_authorization_code" }

  describe ".call" do
    it "builds auth client" do
      context

      expect(context.auth_client).to be_instance_of(Signet::OAuth2::Client)
      expect(context.auth_client).to have_attributes(expected_attributes)
      expect(context.auth_client.authorization_uri.to_s).to eq(expected_authorization_uri)
      expect(context.auth_client.redirect_uri.to_s).to eq(expected_redirect_uri)
      expect(context.auth_client.token_credential_uri.to_s).to eq(expected_token_credential_uri)
    end
  end
end
