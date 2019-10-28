FactoryBot.define do
  factory :user do
    email { "#{junk}@test.test" }
    password { 'reallylongpassword' }
    confirmed_at { DateTime.now }
    first_time { false }
    association :user_role, factory: :user_role
    association :region, factory: :region

    trait :admin do
      after(:create) do |user|
        user.user_role = FactoryBot.create(:user_role, :admin)
        user.save
      end
    end
  end
end
