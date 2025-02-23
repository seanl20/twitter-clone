FactoryBot.define do
  factory :notification do
    association :user
    association :actor
    tweet { nil }
    verb { Constants::Notification::VERBS[:follow] }
  end
end
