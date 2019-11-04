FactoryBot.define do
  factory :entry do
    entry_name { "name" }
    description { "description" }

    association :user, factory: :user
    association :category, factory: :category
    association :timeslot, factory: :timeslot
    association :fair, factory: :fair

    trait :unassigned do
      timeslot { nil }
    end
  end
end
