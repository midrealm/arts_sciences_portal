FactoryBot.define do
  factory :judge_assign do
    association :entry, factory: :entry
    association :user, factory: :user
    association :timeslot, factory: :timeslot
  end
end
