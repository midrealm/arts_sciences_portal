FactoryBot.define do
  factory :category do
    name { "category" }

    association :division, factory: :division

    after(:create) do |category|
      category.division = FactoryBot.create(:division)
      category.save
    end
  end
end
