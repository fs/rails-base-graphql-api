require_relative "dummy/jwt_token"

FactoryBot.define do
  factory :refresh_token do
    user
    expires_at { 1.year.since }
    jti { "jti" }
    token do
      Dummy::JWTToken.new(
        user_id: user.id,
        exp: expires_at.to_i,
        jti: jti,
        type: "refresh"
      ).token
    end

    trait :expired do
      expires_at { 1.hour.ago }
    end
  end
end
