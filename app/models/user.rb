class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :user_role

  has_many :entries
  has_many :judge_assigns

  def admin?
    self.user_role.role_name == "admin"
  end
end
