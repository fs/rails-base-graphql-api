class AccessToken
  attr_reader :jti

  def initialize(attrs)
    @token = attrs[:token]
    @user_id = attrs[:user_id]
    @exp = attrs[:exp]
    @jti = attrs[:jti]
  end

  def token
    @token ||= JWT.encode(payload, ENV.fetch("AUTH_SECRET_TOKEN"), "HS256")
  end

  private

  def payload
    {
      sub: @user_id || 1,
      exp: @exp || Time.current.to_i,
      jti: @jti || "1",
      type: "access"
    }
  end
end

FactoryBot.define do
  factory :access_token do
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
