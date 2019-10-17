FactoryBot.define do
  factory :judge_preference do

    association :category, factory: :category
    association :user, factory: :user
  end
end
