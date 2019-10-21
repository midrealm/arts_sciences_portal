class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  belongs_to :user_role
  belongs_to :region

  has_many :entries
  has_many :judge_assigns
  has_many :judge_preferences

  def initialize(attributes=nil)
    attr_with_role = attributes.nil? ? nil : {:user_role => UserRole.default_user}.merge(attributes)
    super(attr_with_role)
  end

  def admin?
    self.user_role.role_name == "admin"
  end
end
