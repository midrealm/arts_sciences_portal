FactoryBot.define do
  factory :location do
    description { "MyString" }
    association :fair, factory: :fair
  end
end
