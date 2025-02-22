FactoryBot.define do
  factory :notification do
    association :user
    association :actor
    tweet { nil }
    verb { "MyString" }
  end
end
