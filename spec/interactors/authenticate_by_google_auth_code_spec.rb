require "rails_helper"

describe AuthenticateByGoogleAuthCode do
  subject { described_class.organized }

  let(:expected_interactors) do
    [
      Omniauth::Google::BuildAuthClient,
      Omniauth::Google::ExchangeAuthCode,
      Omniauth::Google::FetchUserInfo,
      Omniauth::Google::FindOrCreateUser
    ]
  end

  it { is_expected.to eq(expected_interactors) }
end
