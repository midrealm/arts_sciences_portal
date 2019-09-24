class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :user_role

  has_many :entries, class_name: 'Entry', foreign_key: :user_id
  has_many :judge_assigns, class_name: 'JudgeAssign', foreign_key: :user_id

  def admin?
    self.user_role.role_name == "admin"
  end
end
