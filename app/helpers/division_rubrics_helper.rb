module DivisionRubricsHelper
  def criteria_type_heading(criteria_type)
    criteria_type.name.presence || criteria_type.description
  end

  def rubric_criteriums(criteria_type, show_deprecated:)
    scope = criteria_type.criteriums.order(:suggested_score, :id)
    show_deprecated ? scope : scope.where(deprecated: false)
  end

  def rubric_child_types(criteria_type, division, show_deprecated:)
    scope = CriteriaType.children_for(criteria_type).applicable(division)
    show_deprecated ? scope : scope.where(deprecated: false)
  end

  def rubric_deprecated_badge(record)
    return unless record.deprecated?

    content_tag(:span, "Deprecated", class: "badge text-bg-warning ms-2")
  end
end
