FactoryBot.define do
  factory :refresh_token do
    association :user
    token { "token" }
    expires_at { 1.year.since }
    client_uid { "clietnt_uid" }
  end
end
