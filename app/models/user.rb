class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  belongs_to :user_role
  belongs_to :region

  has_many :user_entries
  has_many :judge_assigns
  has_many :judge_preferences
  has_many :judge_fairs
  has_many :user_peerages
  has_many :peerages, through: :user_peerages

  scope :volunteered, -> (fair) { joins(:judge_fairs).where('judge_fairs.fair_id = ?', fair.id) }
  scope :judge_assigned_entries, -> (user) { joins(:judge_assigns).where('judge_assigns.user_id = ?', user.id) }

  def initialize(attributes=nil)
    attr_with_role = attributes.nil? ? nil : {:user_role => UserRole.default_user}.merge(attributes)
    super(attr_with_role)
  end

  def admin?
    self.user_role.role_name == "admin"
  end

  def selected_categories
    JudgePreference.where(user_id: self.id).pluck(:category_id)
  end

  def email_or_name
    self.sca_name.nil? ? self.email : self.sca_name
  end

  def judging_entry?(entry)
    !JudgeAssign.find_by(entry_id: entry.id, user_id: self.id).nil?
  end

  def color_class(entry)
    return "blue" unless self.judge_preferences.where(category_id: entry.category_id).empty?
    "black"
  end

  def display_peerages
    peerage_string = peerages.map do |peerage|
      peerage.description[0]
    end.join(" ")
    peerage_string.blank? ? "" : "(#{peerage_string})"
  end
end
