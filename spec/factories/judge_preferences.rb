FactoryBot.define do
  factory :judge_preference do

    association :division, factory: :division
    association :user, factory: :user
  end
end
