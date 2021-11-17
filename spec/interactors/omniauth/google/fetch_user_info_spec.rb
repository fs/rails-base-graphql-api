require "rails_helper"
require "google/apis/oauth2_v2"

describe Omniauth::Google::FetchUserInfo do
  subject(:context) { described_class.call(auth_client: auth_client_double) }

  let(:auth_client_double) { instance_double "Signet::OAuth2::Client" }
  let(:oauth_2_service_double) { instance_double "Google::Apis::Oauth2V2::Oauth2Service" }
  let(:userinfo_double) { instance_double "Google::Apis::Oauth2V2::Userinfo" }
  let(:expected_options) { { options: { authorization: auth_client_double } } }

  before do
    allow(Google::Apis::Oauth2V2::Oauth2Service).to receive(:new).and_return(oauth_2_service_double)
    allow(oauth_2_service_double).to receive(:get_userinfo).with(expected_options).and_return(userinfo_double)
  end

  describe ".call" do
    it "exchanges auth code to access token and refresh token" do
      expect(context.user_info).to be(userinfo_double)
    end
  end
end
