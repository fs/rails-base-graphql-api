FactoryBot.define do
  sequence :user_email do |n|
    "user_#{n}@example.com"
  end
end
