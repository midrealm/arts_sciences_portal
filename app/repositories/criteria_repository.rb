class CriteriaRepository
  def self.active_criteria
    Criterium.joins(:criteria_type).where(criteria_types: {deprecated: false})
  end
end
