FactoryBot.define do
  factory :user do
    email { "john@white.com" }
    password { "12341234" }
    password_confirmation { "12341234" }
  end
end
