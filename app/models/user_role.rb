class UserRole < ApplicationRecord
  has_many :users

  def self.default_user
    self.all.where(role_name: 'user').first
  end
end
