FactoryBot.define do
  factory :tweet_activity do
    association :user
    association :tweet
    verb { Constants::TweetActivity::VERBS_VALIDATION.sample }
  end
end
