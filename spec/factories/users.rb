FactoryBot.define do
  factory :user do
    email { generate(:user_email) }
    password { "password" }
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.first_name }
  end
end
