FactoryBot.define do
  factory :tweet do
    association :user

    body { "MyString" }
  end
end
