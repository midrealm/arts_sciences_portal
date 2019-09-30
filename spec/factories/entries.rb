FactoryBot.define do
  factory :entry do
    entry_name { "name" }
    description { "description" }

    association :user, factory: :user
    association :category, factory: :category
  end
end
