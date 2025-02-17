FactoryBot.define do
  factory :message do
    association :user
    body { "MyText" }
  end
end
