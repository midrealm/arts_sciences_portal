FactoryBot.define do
  factory :preference do
    sequence(:name) { |n| "Preference #{n}" }
  end
end
