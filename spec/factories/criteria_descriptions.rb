FactoryBot.define do
  factory :criteria_description do
    description { "MyText" }

    association :category, factory: :category
    association :criteria_type, factory: :criteria_type
  end
end
