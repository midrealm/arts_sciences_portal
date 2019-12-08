FactoryBot.define do
  factory :scoresheet do
    association :user, factory: :user
    association :entry, factory: :entry
  end
end
