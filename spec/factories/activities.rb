FactoryBot.define do
  factory :activity do
    title { generate(:activity_title) }
    body { "New user registered." }
    event { :user_registered }
    user

    trait :public do
      event { :user_registered }
    end

    trait :private do
      event { :user_updated }
    end
  end
end
