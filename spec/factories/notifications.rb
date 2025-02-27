FactoryBot.define do
  factory :notification do
    association :user
    association :actor
    tweet { nil }
    verb { Constants::Notification::VERBS_VALIDATION.sample }
  end
end
