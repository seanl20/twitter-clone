FactoryBot.define do
  factory :view do
    association :tweet
    association :user
  end
end
