class AuthenticateByGoogleAuthCode
  include Interactor::Organizer

  organize Omniauth::Google::BuildAuthClient,
           Omniauth::Google::ExchangeAuthCode,
           Omniauth::Google::FetchUserInfo,
           Omniauth::Google::FindOrCreateUser
end
