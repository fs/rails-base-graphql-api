FactoryBot.define do
  factory :refresh_token do
    user
    token do
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTkxNzA1ODAwLCJqdGkiOiJqdGkiLCJ0eXBlIj" \
        "oicmVmcmVzaCJ9.rLewPTwiODP_ZkGvSN7h_WHGC1xv2DC7r_ne-cggcVo"
    end
    expires_at { 1.year.since }
    jti { "jti" }

    trait :expired do
      expires_at { 1.hour.ago }
    end

    trait :access do
      token do
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTg5MTE3NDAwLCJqdGkiOiJqdGkiLCJ0eXBlIj" \
          "oiYWNjZXNzIn0.8_wgyeDCmb61L07TRlBNLcoxCMqMUuK0kEw_fKCWGeQ"
      end
    end

    trait :refresh do
      token do
        "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOjExMTExMSwiZXhwIjoxNTkxNzA1ODAwLCJqdGkiOiJqdGkiLCJ0eXBlIj" \
          "oicmVmcmVzaCJ9.rLewPTwiODP_ZkGvSN7h_WHGC1xv2DC7r_ne-cggcVo"
      end
    end
  end
end
