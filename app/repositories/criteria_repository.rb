class CriteriaRepository
  def self.active_criteria
    Criterium.joins(:criteria_type)
             .where(criteria: {deprecated: false})
             .where(criteria_types: {deprecated: false})
  end

  def self.deprecated_criteria
    Criterium.joins(:criteria_type).where(criteria: {deprecated: true})
  end

  def self.for_index(show_deprecated:)
    scope = show_deprecated ? deprecated_criteria : active_criteria
    scope.joins(criteria_type: :division).order('criteria_types.division_id', :criteria_type_id)
  end
end
