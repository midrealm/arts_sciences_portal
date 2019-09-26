FactoryBot.define do
  factory :fair do
    date { "2019-09-25" }
    name { 'fair' }
    comment { 'comment' }
    internet_access { true }

    association :region, factory: :region
  end
end
