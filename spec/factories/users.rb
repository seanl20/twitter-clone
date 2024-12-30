FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@email.com" }
    password { "password" }
    username { Faker::Internet.username }
  end
end
