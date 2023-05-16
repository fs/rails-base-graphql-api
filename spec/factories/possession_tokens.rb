FactoryBot.define do
  factory :possession_token do
    user

    value { "token" }
  end
end
