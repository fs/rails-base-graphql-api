FactoryBot.define do
  factory :user do
    email { generate(:user_email) }
    password { "password" }
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.first_name }

    trait :with_reset_token do
      password_reset_token { 'reset_token' }
      password_reset_sent_at { Time.zone.now }
    end
  end
end
