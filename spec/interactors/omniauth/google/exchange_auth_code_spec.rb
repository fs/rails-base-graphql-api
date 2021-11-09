require "rails_helper"

describe Omniauth::Google::ExchangeAuthCode do
  subject(:context) { described_class.call(auth_client: auth_client_double) }

  let(:auth_client_double) { instance_double "Signet::OAuth2::Client" }

  before do
    allow(auth_client_double).to receive(:fetch_access_token!)
  end

  describe ".call" do
    it "exchanges auth code to access token and refresh token" do
      expect(context).to be_success
    end
  end
end
