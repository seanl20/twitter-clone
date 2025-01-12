FactoryBot.define do
  factory :retweet do
    association :tweet
    association :user
  end
end
