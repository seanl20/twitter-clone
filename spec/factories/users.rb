FactoryBot.define do
  factory :user do
    password { "password" }
    username { Faker::Internet.username }
    email { Faker::Internet.email }
  end
end
