class CriteriaTypeRepository
  def self.active_criteria
    CriteriaType.where(deprecated: false)
  end

  def self.by_scoresheet(scoresheet_id)
    criteria_type_ids = Scoresheet.find(scoresheet_id).scores.pluck(:criteria_type_id)
    CriteriaType.where(id: criteria_type_ids)
  end
end
