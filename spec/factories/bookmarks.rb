FactoryBot.define do
  factory :bookmark do
    association :tweet
    association :user
  end
end
