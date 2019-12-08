FactoryBot.define do
  factory :score do
    comment { "MyText" }
    score { 1 }

    association :criteria_type, factory: :criteria_type
  end
end
