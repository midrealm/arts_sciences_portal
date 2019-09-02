class UserRole < ApplicationRecord
  has_many :users, class_name: 'User', foreign_key: :user_role_id
end
