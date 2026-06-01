FactoryBot.define do
  factory :entry do
    entry_name { "name" }
    description { "description" }

    association :division, factory: :division
    association :timeslot, factory: :timeslot
    association :fair, factory: :fair

    trait :unassigned do
      timeslot { nil }
    end
  end
end
