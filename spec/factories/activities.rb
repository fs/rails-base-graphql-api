FactoryBot.define do
  factory :activity do
    title { generate(:activity_title) }
    body { "New user registered." }
    event { :user_registered }
    user
  end
end
