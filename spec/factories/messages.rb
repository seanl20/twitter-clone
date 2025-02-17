FactoryBot.define do
  factory :message do
    association :user
    association :message_thread
    body { "MyText" }
  end
end
