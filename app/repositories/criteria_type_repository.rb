class CriteriaTypeRepository
  def self.active_criteria
    CriteriaType.where(deprecated: false)
  end

  def self.deprecated_criteria
    CriteriaType.where(deprecated: true)
  end

  def self.for_index(show_deprecated:)
    show_deprecated ? deprecated_criteria : active_criteria
  end

  def self.by_scoresheet(scoresheet_id)
    criteria_type_ids = Scoresheet.find(scoresheet_id).scores.pluck(:criteria_type_id)
    CriteriaType.where(id: criteria_type_ids)
  end
end
