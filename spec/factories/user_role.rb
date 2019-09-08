FactoryBot.define do
  factory :user_role do
    role_name { 'user' }
  end

  trait :admin do
    role_name { 'admin' }
  end
end
