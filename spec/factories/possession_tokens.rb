FactoryBot.define do
  factory :possession_token do
    association :user

    value { "token" }
  end
end
