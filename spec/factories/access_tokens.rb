require_relative "dummy/jwt_token"

FactoryBot.define do
  factory :access_token, class: "Dummy::JWTToken" do
    initialize_with { new(attributes) }

    user_id { rand(1_000_000) }
    exp { 1.hour.since.to_i }
    jti { SecureRandom.hex }

    trait :invalid do
      token { "bad_token" }
    end

    trait :expired do
      exp { 1.hour.ago.to_i }
    end
  end
end
