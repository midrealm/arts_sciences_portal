FactoryBot.define do
  factory :criteria_description do
    description { "MyText" }

    association :division, factory: :division
    association :criteria_type, factory: :criteria_type
  end
end
