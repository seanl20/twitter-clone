FactoryBot.define do
  factory :message_threads_user do
    association :message_thread
    association :user
  end
end
