FactoryBot.define do
  factory :activity do
    title { generate(:activity_title) }
    body { "New user registered." }
    user
  end
end
