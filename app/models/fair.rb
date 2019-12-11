class Fair < ApplicationRecord
  belongs_to :region

  has_many :entries
  has_many :judge_fairs

  def name_with_warning
    self.internet_access ? self.name : "#{self.name} - WARNING: electronic judging not available"
  end
end
