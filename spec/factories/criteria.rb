FactoryBot.define do
  factory :criterium do
    description { "MyString" }
    suggested_score { 1 }
    optional { false }

    association :division, factory: :division
    association :criteria_type, factory: :criteria_type
  end
end
