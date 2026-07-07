FactoryBot.define do
  factory :judge_preference do
    association :preference, factory: :preference
    association :user, factory: :user
  end
end
