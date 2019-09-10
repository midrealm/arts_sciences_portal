FactoryBot.define do
  factory :user do
    email { "#{junk}@test.test" }
    password { 'reallylongpassword' }
    association :user_role, factory: :user_role

    trait :admin do
      after(:create) do |user|
        user.user_role = FactoryBot.create(:user_role, :admin)
        user.save
      end
    end
  end
end
