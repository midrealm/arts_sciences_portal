FactoryBot.define do
  factory :criterium do
    description { "MyString" }
    criteria_type { nil }
    division { nil }
    category { nil }
    score_range { 1 }
    optional { false }
    animal { false }
  end
end
